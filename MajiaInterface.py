import maya.cmds as cmds
import maya.mel as mel
import random
import math
import os
import shutil


try:
    import mtoa.utils as mutils
except ImportError:
    pass

from PySide2 import QtWidgets, QtCore, QtGui

magic_win = None


# CONFIGURATION GLOBALE
bookGRP = "majia_model_grimoire_publish:grimoire_grp"
bookSizeCtrl = "majia_model_grimoire_publish:bookSize_ctrl"
coverCtrl = "majia_model_grimoire_publish:cover_ctrl"
spineCtrl = "majia_model_grimoire_publish:spine_ctrl"
defaultSpineH = 1.33 


# FONCTIONS TEXTURES & MATERIALS
def nettoyer_anciens_materials():
    materials_a_supprimer = ["page01", "page02", "page03", "pageMatea"]
    for material in materials_a_supprimer:
        if cmds.objExists(f"{material}_SG"): cmds.delete(f"{material}_SG")
        if cmds.objExists(material): cmds.delete(material)
        if cmds.objExists(f"{material}_file"): cmds.delete(f"{material}_file")

def creer_page_material(page_name, chemin_texture):
    if cmds.objExists(page_name):
        return page_name, f"{page_name}_SG"
    
    material = cmds.shadingNode('aiStandardSurface', asShader=True, name=page_name)
    shading_group = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name=f"{page_name}_SG")
    cmds.connectAttr(f"{material}.outColor", f"{shading_group}.surfaceShader", force=True)
    
    file_node = cmds.shadingNode('file', asTexture=True, name=f"{page_name}_file")
    if chemin_texture and os.path.exists(chemin_texture):
        cmds.setAttr(f"{file_node}.fileTextureName", chemin_texture, type="string")
    
    cmds.connectAttr(f"{file_node}.outColor", f"{material}.baseColor", force=True)
    
    # Gestion transparence si PNG alpha
    if cmds.attributeQuery("outTransparency", node=file_node, exists=True):
         cmds.connectAttr(f"{file_node}.outTransparency", f"{material}.opacity", force=True)

    cmds.setAttr(f"{material}.specularRoughness", 0.832)
    if page_name == "pageMatea":
        cmds.setAttr(f"{material}.specularRoughness", 1)

    return material, shading_group

def assigner_material_a_page(page_mesh, shading_group):  
    cmds.select(page_mesh, replace=True)
    cmds.sets(edit=True, forceElement=shading_group)

def cut_edges_uvs(page_mesh, edge_ranges):
    for start, end in edge_ranges:
        cmds.select(f"{page_mesh}.e[{start}:{end}]", replace=True)
        cmds.polyMapCut()

def centre_scale_uvshell(page_mesh, face_range):
    start, end = face_range
    cmds.select(f"{page_mesh}.f[{start}:{end}]", replace=True)
    uvs = cmds.polyListComponentConversion(toUV=True)
    cmds.select(uvs, replace=True)
    uv_list = cmds.ls(selection=True, flatten=True)
    
    u_coords = cmds.polyEditUV(uv_list, query=True)[0::2]
    v_coords = cmds.polyEditUV(uv_list, query=True)[1::2]
    
    move_u = 0.5 - ((min(u_coords) + max(u_coords)) / 2.0)
    move_v = 0.5 - ((min(v_coords) + max(v_coords)) / 2.0)
    
    cmds.polyEditUV(uv_list, u=move_u, v=move_v, relative=True)
    cmds.polyEditUV(uv_list, scaleU=3, scaleV=3, pivotU=0.5, pivotV=0.5, relative=False)
    cmds.polyEditUV(uv_list, scaleU=0.92, scaleV=1.0, pivotU=0.5, pivotV=0.5, relative=True)

def rotate_uvs(page_mesh, angle=-90):
    cmds.select(f"{page_mesh}.map[*]", replace=True)
    cmds.polyEditUV(angle=angle, pivotU=0.5, pivotV=0.5)

def texturer_pages(page_mesh, page_name, chemins_textures):
    material, shading_group = creer_page_material(page_name, chemins_textures)
    assigner_material_a_page(page_mesh, shading_group)
    rotate_uvs(page_mesh, angle=-90)
    cut_edges_uvs(page_mesh, [(144, 155), (288, 299), (432, 443)])
    centre_scale_uvshell(page_mesh, (144, 287))
    centre_scale_uvshell(page_mesh, (432, 575))


# LOGIQUE GRIMOIRE
def creer_pages(nombre_pages, nombre_pages_a_tourner, textures_dict):
    if cmds.objExists("Pages_GRP"): cmds.delete("Pages_GRP")
    if cmds.objExists("Pages_RIG_GRP"): cmds.delete("Pages_RIG_GRP")
    nettoyer_anciens_materials()

    pages_grp = cmds.group(empty=True, name="Pages_GRP")
    all_pages, all_bends, coordonnees = [], [], []
    
    epaisseur = 0.015
    y_base = 0
    reliure_z = 0
    
    mySpineH = epaisseur * nombre_pages
    spineMove = mySpineH - defaultSpineH if mySpineH > defaultSpineH else 0
    if cmds.objExists(bookSizeCtrl):
        cmds.move(0, spineMove, 0, bookSizeCtrl, a=True)
    
    rayon = defaultSpineH / math.pi
    default_nombre_pages = int(defaultSpineH / epaisseur)
    
    if nombre_pages < default_nombre_pages:
        finPremierQuart = int(nombre_pages / 2)
        debutDeuxiemeQuart = finPremierQuart
        nbPagesCercle = nombre_pages
    else:
        finPremierQuart = int(default_nombre_pages / 2)
        debutDeuxiemeQuart = nombre_pages - finPremierQuart
        nbPagesCercle = finPremierQuart * 2
    
    # Calcul positions
    for i in range(finPremierQuart):
        angle = math.pi * (i / (nbPagesCercle - 1) - 1/2)
        w = 9.4 - random.uniform(0, 0.1)
        d = 6.6 - random.uniform(0, 0.1)
        x = random.uniform(-0.05, 0.05)
        y = y_base + rayon * (math.sin(angle) + 1)
        z_base = reliure_z - d/2
        ondulation = math.sin((i / (nombre_pages - 1)) * math.pi) * 0.15
        z = z_base + rayon * math.cos(angle) + ondulation
        coordonnees.append((w, d, x, y, z))
    
    y_offset, z_offset = y, z - z_base - ondulation
    
    for i in range(finPremierQuart, debutDeuxiemeQuart):
        w = 9.4 - random.uniform(0, 0.1)
        d = 6.6 - random.uniform(0, 0.1)
        x = random.uniform(-0.05, 0.05)
        y = y_offset + (i-finPremierQuart) * epaisseur
        z_base = reliure_z - d/2
        ondulation = math.sin((i / (nombre_pages - 1)) * math.pi) * 0.15
        z = z_base + z_offset + ondulation
        coordonnees.append((w, d, x, y, z))
        
    y_offset = y - y_offset
    
    for i in range(debutDeuxiemeQuart, nombre_pages):
        angle = math.pi * ((i - debutDeuxiemeQuart + finPremierQuart) / (nbPagesCercle - 1) - 1/2)
        w = 9.4 - random.uniform(0, 0.1)
        d = 6.6 - random.uniform(0, 0.1)
        x = random.uniform(-0.05, 0.05)
        y = y_offset + y_base + rayon * (math.sin(angle) + 1)
        z_base = reliure_z - d/2
        ondulation = math.sin((i / (nombre_pages - 1)) * math.pi) * 0.15
        z = z_base + rayon * math.cos(angle) + ondulation
        coordonnees.append((w, d, x, y, z))

    page_du_milieu = nombre_pages - nombre_pages_a_tourner
    page_matea_index = page_du_milieu - 1 if page_du_milieu % 2 == 0 else page_du_milieu

    # Création Mesh
    for i in range(nombre_pages):
        (w, d, x, y, z) = coordonnees[i]
        page = cmds.polyCube(name=f"Page_{i+1:03d}", w=w, h=epaisseur, d=d, sx=12, sy=12, sz=12)[0]
        
        if textures_dict:
            if (i + 1) == page_matea_index:
                texturer_pages(page, "pageMatea", textures_dict.get("pageMatea", ""))
            else:
                key = f"page0{(i % 3) + 1}"
                texturer_pages(page, key, textures_dict.get(key, ""))
        
        cmds.move(x, y, z, page)
        cmds.parent(page, pages_grp)
        all_pages.append(page)
        
        cmds.select(page)
        bend_result = cmds.nonLinear(n=f"bend_{i+1}", type='bend')
        bend_deformer, bend_handle = bend_result[0], bend_result[1]
        cmds.move(x, y, z+d, bend_handle)
        cmds.rotate(90, 0, 90, bend_handle)
        cmds.setAttr(bend_deformer + ".highBound", 0)
        all_bends.append(bend_result)

    return all_pages, all_bends

def rigger_pages():
    if not cmds.objExists("Pages_GRP"): return
    if cmds.objExists("Pages_RIG_GRP"): cmds.delete("Pages_RIG_GRP")
    
    all_pages = cmds.listRelatives("Pages_GRP", children=True, type='transform')
    if not all_pages: return
    
    rig_grp = cmds.group(empty=True, name="Pages_RIG_GRP")
    all_controls = []
    
    i=1
    for page in all_pages:
        bbox = cmds.exactWorldBoundingBox(page)
        pivot_x, pivot_y, pivot_z = (bbox[0] + bbox[3]) / 2, cmds.getAttr(f"{page}.translateY"), bbox[5]
        
        ctrl = cmds.spaceLocator(name=f"{page}_CTRL")[0]
        cmds.move(pivot_x, pivot_y, pivot_z, ctrl)
        
        page_pos = cmds.xform(page, q=True, ws=True, t=True)
        page_rot = cmds.xform(page, q=True, ws=True, rotation=True)
        
        cmds.parent(page, ctrl)
        cmds.parent("bend_"+str(i)+"Handle", ctrl)
        
        cmds.xform(page, worldSpace=True, translation=page_pos)
        cmds.xform(page, worldSpace=True, rotation=page_rot)
        
        cmds.makeIdentity(page, apply=True, translate=True, rotate=True, scale=True)
        cmds.parent(ctrl, rig_grp)
        all_controls.append(ctrl)
        i+=1
    
    if cmds.objExists("Pages_GRP"):
        descendants = cmds.listRelatives("Pages_GRP", allDescendents=True) or []
        if len(descendants) == 0:
            try: cmds.delete("Pages_GRP")
            except Exception: pass

    return all_controls

def animer_pages(all_bends, nombre_pages, nombre_pages_a_tourner, frame_debut, duree_normale, duree_lente, temps_minimum_animation_page, frame_ferme=20, frame_ouvre=37):
    if not cmds.objExists("Pages_RIG_GRP"): return 0
    all_controls = cmds.listRelatives("Pages_RIG_GRP", children=True, type='transform')
    if not all_controls: return 0
    
    all_controls.sort()
    controls_a_animer = all_controls[(-nombre_pages_a_tourner-1):]
    controls_a_animer.reverse()
    
    bends_a_animer = all_bends[(-nombre_pages_a_tourner-1):]
    bends_a_animer.reverse()

    epaisseur = 0.015
    M, power = len(controls_a_animer), 10.6
    
    if M <= temps_minimum_animation_page:
        durations = [max(temps_minimum_animation_page, int(duree_lente))] * M
    else:
        durations = []
        for i in range(M):
            t = (i / (M - 1)) ** power
            dur = duree_normale + (duree_lente - duree_normale) * t
            durations.append(max(1, int(round(dur))))
    
    mySpineH = max(epaisseur * nombre_pages, defaultSpineH)

    for i, ctrl in enumerate(all_controls):
        y_start, z_start = cmds.getAttr(f"{ctrl}.translateY"), cmds.getAttr(f"{ctrl}.translateZ")
        z_end = (i+1) * mySpineH / nombre_pages
        
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_start, time=frame_ferme)
        cmds.setKeyframe(ctrl, attribute='translateY', value=0, time=frame_ouvre, inTangentType="linear")
        cmds.setKeyframe(ctrl, attribute='translateZ', value=z_start, time=frame_ferme, outTangentType="linear")
        cmds.setKeyframe(ctrl, attribute='translateZ', value=z_end, time=frame_ouvre)
        
        maxAngle = 90 * (1 - math.exp(-.00811 * nombre_pages))
        angle = (i+1) * maxAngle / nombre_pages
        cmds.setKeyframe(ctrl, attribute='rotateX', value=0, time=frame_ferme)
        cmds.setKeyframe(ctrl, attribute='rotateX', value=angle, time=frame_ouvre)
        
        myBend = all_bends[i]
        bend_deformer = myBend[0]
        curvAngle = -2 * angle
        cmds.setKeyframe(bend_deformer, attribute="curvature", value=0, time=frame_ferme)
        cmds.setKeyframe(bend_deformer, attribute="curvature", value=curvAngle, time=frame_ouvre, inTangentType="linear")
        cmds.setKeyframe(bend_deformer, attribute="lowBound", value=-1, time=frame_ferme, outTangentType="linear")
        cmds.setKeyframe(bend_deformer, attribute="lowBound", value=-.5, time=frame_ouvre, inTangentType="linear")
    
    if cmds.objExists(coverCtrl):
        cmds.cutKey(coverCtrl, attribute="rotateX")
        cmds.rotate(0, 0, 0, coverCtrl, a=True)
        cmds.setKeyframe(coverCtrl, attribute='rotateX', value=0, time=frame_ferme)
        cmds.setKeyframe(coverCtrl, attribute='rotateX', value=90, time=frame_ouvre)
    
    if cmds.objExists(spineCtrl):
        cmds.cutKey(spineCtrl, attribute="rotateX")
        cmds.rotate(0, 0, 0, spineCtrl, a=True)
        cmds.setKeyframe(spineCtrl, attribute='rotateX', value=0, time=frame_ferme)
        cmds.setKeyframe(spineCtrl, attribute='rotateX', value=90, time=frame_ouvre)
    
    frame_actuelle = frame_debut
    for i, ctrl in enumerate(controls_a_animer):
        duree = durations[i] 
        frame_fin = frame_actuelle + duree
        rotate_x_start = cmds.getAttr(ctrl + ".rotateX", time=frame_actuelle)
        rotate_x_end = 180 - i * maxAngle / nombre_pages

        cmds.cutKey(ctrl, attribute="rotateX", time=(frame_actuelle, frame_fin))
        cmds.setKeyframe(ctrl, attribute='rotateX', value=rotate_x_start, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='rotateX', value=rotate_x_end, time=frame_fin)
        cmds.keyTangent(ctrl, attribute='rotateX', inTangentType='auto', outTangentType='auto')
        
        variation_z = random.uniform(-1, 1)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=variation_z, time=frame_actuelle + duree//2)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_fin)
        
        myBend = all_bends[nombre_pages - i - 1]
        bend_deformer = myBend[0]
        curvAngle_start = cmds.getAttr(bend_deformer + ".curvature", time=frame_actuelle)
        curvAngle_mid = -nombre_pages / 20 + 102.5
        curvAngle_end = -2 * (rotate_x_end - 180)

        cmds.cutKey(bend_deformer, attribute="curvature", time=(frame_actuelle, frame_fin))
        frame_mid = int((frame_actuelle + frame_fin) / 2)

        cmds.setKeyframe(bend_deformer, attribute="curvature", value=curvAngle_start, time=frame_actuelle, inTangentType="plateau", outTangentType="spline")
        cmds.setKeyframe(bend_deformer, attribute="curvature", value=curvAngle_mid, time=frame_mid, inTangentType="spline", outTangentType="linear")
        cmds.setKeyframe(bend_deformer, attribute="curvature", value=curvAngle_end, time=frame_fin, inTangentType="auto")

        if (frame_actuelle < frame_ouvre):
            cmds.keyTangent(bend_deformer, attribute="curvature", time=(frame_ferme, frame_actuelle), inTangentType="linear", outTangentType="fast")

        cmds.setKeyframe(bend_deformer, attribute="lowBound", value=-.5, time=frame_actuelle, outTangentType="linear")
        cmds.setKeyframe(bend_deformer, attribute="lowBound", value=-1, time=frame_mid, outTangentType="linear")
        cmds.setKeyframe(bend_deformer, attribute="lowBound", value=-.5, time=frame_fin, inTangentType="linear")
        cmds.keyTangent(bend_deformer, attribute="lowBound", inTangentType='linear', outTangentType='linear')
        
        frame_actuelle += duree - 2
       
    frame_finale = frame_actuelle + 10
    
    if cmds.objExists(bookGRP) and cmds.objExists("Pages_RIG_GRP"):
        if not cmds.listRelatives("Pages_RIG_GRP", parent=True) or cmds.listRelatives("Pages_RIG_GRP", parent=True)[0] != bookGRP:
            try:
                cmds.parent("Pages_RIG_GRP", bookGRP)
                cmds.move(0, 0, 3.727, "Pages_RIG_GRP", relative = True)
            except: pass
    
    return frame_finale


# PARTICULES, LUMIERES & CAMERA
def creer_particules_magiques(frame_debut_particules, duree_emission, nb_particules, force_vortex, couleur_particules=(1.0, 0.84, 0.0)):
    # Nettoyage complet
    objets_a_supprimer = ["particules_magiques", "emetteur_particules", "gravity_up", "turbulence_magique", "vortex_spirale", 
                          "shader_particules_magiques", "particulesSG", "sphere_instance_1", "sphere_instance_2", 
                          "sphere_instance_3", "instancer_particules", "Particules_GRP"]
    
    for obj in objets_a_supprimer:
        if cmds.objExists(obj): 
            cmds.delete(obj)
    
    particules_grp = cmds.group(empty=True, name="Particules_GRP")
    emetteur_pos = [0, 0, 4.41]
    
    # Système de particules
    particules = cmds.particle(name="particules_magiques")[0]
    particule_shape = cmds.listRelatives(particules, shapes=True)[0]
    
    emetteur = cmds.emitter(
        pos=emetteur_pos, 
        name="emetteur_particules", 
        type='omni',
        rate=nb_particules,
        speed=3.0,
        speedRandom=1.5,
        directionX=0,
        directionY=1,
        directionZ=0,
        spread=0.3
    )[0]
    
    cmds.connectDynamic(particule_shape, em=emetteur)
    
    # Champs de force
    gravity_field = cmds.gravity(pos=emetteur_pos, name="gravity_up", magnitude=9.8, attenuation=0, directionY=1)[0]
    turb_field = cmds.turbulence(pos=emetteur_pos, name="turbulence_magique", magnitude=1.0, attenuation=0.2, frequency=1.5)[0]
    vortex_field = cmds.vortex(pos=emetteur_pos, name="vortex_spirale", magnitude=force_vortex, attenuation=0.1, axisY=1)[0]
    
    cmds.connectDynamic(particule_shape, fields=[gravity_field, turb_field, vortex_field])
    
    # Attributs custom
    cmds.setAttr(f"{particule_shape}.particleRenderType", 3)
    
    # IMPORTANT : Créer objectIndex en premier
    cmds.addAttr(particule_shape, longName='objectIndex', dataType='doubleArray')
    cmds.addAttr(particule_shape, longName='objectIndex0', dataType='doubleArray')
    
    # Expression pour objectIndex
    cmds.dynExpression(particule_shape, string="objectIndex = floor(rand(0, 2.99));", creation=True)
    
    # SHADER
    shader_part = cmds.shadingNode('lambert', asShader=True, name='shader_particules_magiques')
    cmds.setAttr(shader_part + ".color", *couleur_particules, type="double3")
    cmds.setAttr(shader_part + ".incandescence", couleur_particules[0], couleur_particules[1] * 0.9, couleur_particules[2] * 0.3, type="double3")
    cmds.setAttr(shader_part + ".glowIntensity", 0.5)
    
    sg_part = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name='particulesSG')
    cmds.connectAttr(shader_part + ".outColor", sg_part + ".surfaceShader", f=True)
    
    # SPHÈRES INSTANCIÉES
    sphere1 = cmds.polySphere(name="sphere_instance_1", radius=0.04, subdivisionsAxis=6, subdivisionsHeight=6)[0]
    sphere2 = cmds.polySphere(name="sphere_instance_2", radius=0.05, subdivisionsAxis=6, subdivisionsHeight=6)[0]
    sphere3 = cmds.polySphere(name="sphere_instance_3", radius=0.06, subdivisionsAxis=6, subdivisionsHeight=6)[0]
    
    cmds.sets([sphere1, sphere2, sphere3], e=True, forceElement=sg_part)
    
    # INSTANCER
    instancer = cmds.particleInstancer(
        particule_shape,
        name="instancer_particules",
        object=[sphere1, sphere2, sphere3],
        cycle='None',
        cycleStep=1,
        cycleStepUnits='Frames',
        levelOfDetail='Geometry',
        rotationUnits='Degrees',
        rotationOrder='XYZ',
        age='age',
        objectIndex='objectIndex'
    )
    
    cmds.hide(sphere1, sphere2, sphere3)
    
    # CONFIGURER LES PARTICULES - Couleurs et opacité
    cmds.addAttr(particule_shape, longName='rgbPP', dataType='vectorArray')
    cmds.addAttr(particule_shape, longName='rgbPP0', dataType='vectorArray')
    
    expression_color = f"""
float $variation = rand(0.7, 1.0);
vector $color = <<{couleur_particules[0]} * $variation, {couleur_particules[1]} * $variation, 0.0>>;
rgbPP = $color;
"""
    cmds.dynExpression(particule_shape, string=expression_color, creation=True)
    
    # Opacité
    cmds.addAttr(particule_shape, longName='opacityPP', dataType='doubleArray')
    cmds.addAttr(particule_shape, longName='opacityPP0', dataType='doubleArray')
    
    expression_opacity = """
float $lifespan = 4.0;
opacityPP = 1.0 - (age / $lifespan);
if (opacityPP < 0) opacityPP = 0;
"""
    cmds.dynExpression(particule_shape, string=expression_opacity, runtimeBeforeDynamics=True)
    
    # Durée de vie
    cmds.setAttr(f"{particule_shape}.lifespanMode", 2)
    cmds.setAttr(f"{particule_shape}.lifespan", 4.0)
    cmds.setAttr(f"{particule_shape}.lifespanRandom", 1.5)
    
    # ANIMATION EMISSION
    frame_fin_emission = frame_debut_particules + duree_emission
    for t, v in [(frame_debut_particules-1, 0), (frame_debut_particules, nb_particules), (frame_fin_emission-10, nb_particules), (frame_fin_emission, 0)]:
        cmds.setKeyframe(emetteur, attribute='rate', value=v, time=t)
    
    # Rangement
    for obj in [particules, emetteur, gravity_field, turb_field, vortex_field, instancer, sphere1, sphere2, sphere3]:
        if cmds.nodeType(obj) != "transform":
            parents = cmds.listRelatives(obj, parent=True)
            if parents: obj = parents[0]
        
        try: cmds.parent(obj, particules_grp)
        except: pass
    
    if cmds.objExists(bookGRP):
        try: cmds.parent(particules_grp, bookGRP)
        except: pass

    return particules

def grimoire_flottant(frame_fin_animation, duree_emission):
    if not cmds.objExists(bookGRP): return
    cmds.cutKey(bookGRP, attribute='translateY')
    cmds.setKeyframe(bookGRP, attribute='translateY', value=0, time=0)
    
    finAnim = int(frame_fin_animation + duree_emission * 2.85)
    cmds.setKeyframe(bookGRP, attribute='translateY', value=0, time=finAnim)
    
    for i in range(1, 50):
        val = 0.75 if i % 2 == 1 else -0.75
        time = 60 * i
        if time < finAnim - 30:
            cmds.setKeyframe(bookGRP, attribute='translateY', value=val, time=time)
        else:
            cmds.setKeyframe(bookGRP, attribute='translateY', value=0, time=time)
            break

def gestion_lights_et_camera(frame_debut, duree_emission, frame_fin_animation, butterfly_project_name=""):
    if cmds.objExists("Lights_GRP"): cmds.delete("Lights_GRP")
    if cmds.objExists("Camera_GRP"): cmds.delete("Camera_GRP")
    
    lights_grp = cmds.group(empty=True, name="Lights_GRP")
    camera_grp = cmds.group(empty=True, name="Camera_GRP")

    # Lights
    try:
        mutils.createLocator('aiAreaLight', asLight=True)
        keyArea = cmds.rename('aiAreaLight1', "areaKey_lgt")
        cmds.setAttr("areaKey_lgt.translateX", 7.431)
        cmds.setAttr("areaKey_lgt.translateY", 5.445)
        cmds.setAttr("areaKey_lgt.translateZ", 2.523)
        cmds.setAttr("areaKey_lgt.rotateX", -16.148)
        cmds.setAttr("areaKey_lgt.rotateY", 90)
        cmds.setAttr("areaKey_lgt.scaleX", 15.301)
        cmds.setAttr("areaKey_lgt.scaleY", 4.567)
        cmds.setAttr("areaKey_lgtShape.color", 0.814,0.601,0.415, type="double3")
        cmds.setAttr("areaKey_lgtShape.exposure", 11)
        cmds.parent(keyArea, lights_grp)
        
        mutils.createLocator('aiSkyDomeLight', asLight=True)
        backSky = cmds.rename('aiSkyDomeLight1', "backSky_Grimoire_lgt")
        cmds.setAttr("backSky_Grimoire_lgtShape.color", 0.011,0.003,0.022, type="double3")
        cmds.setAttr("backSky_Grimoire_lgtShape.intensity", 1.850)
        cmds.parent(backSky, lights_grp)
    except:
        pass

    spotFill = cmds.spotLight(n='spotFill_lgt', coneAngle=32, penumbra=10, rgb=[0.814,0.601,0.415], intensity=2500)
    cmds.move(0.272, 20, 3.986, spotFill)
    cmds.rotate(-90, 0, 0, spotFill)
    cmds.parent(spotFill, lights_grp)

    # Camera
    renderCam = cmds.camera(n="renderCamera", nearClipPlane=0.01)[0]
    cmds.parent(renderCam, camera_grp)
    
    # Animation Camera
    cmds.setKeyframe(renderCam, time=0)
    keys = [
        (frame_debut, 22.986, 13.22, 18.076, -25.279, 55.821, 0),
        (frame_fin_animation, 21, 18, 4.338, -41, 90, 0),
        (int(frame_fin_animation + duree_emission/2), 21, 18, 4.338, -41, 90, 0),
        (int(frame_fin_animation + duree_emission*1.75), 1.84, 23.412, 4.427, -86, 90, 0),
        (int(frame_fin_animation + duree_emission*1.92), 1.84, 23.412, 4.427, -86, 90, 0),
        (int(frame_fin_animation + duree_emission*2.85), 0.7, 5.280, 1.070, -90, 90, 0),
        (int(frame_fin_animation + duree_emission*2.97), 0.7, 5.280, 1.070, -90, 90, 0)
    ]
    
    for t, tx, ty, tz, rx, ry, rz in keys:
        cmds.setKeyframe(renderCam, at='translateX', v=tx, time=t)
        cmds.setKeyframe(renderCam, at='translateY', v=ty, time=t)
        cmds.setKeyframe(renderCam, at='translateZ', v=tz, time=t)
        cmds.setKeyframe(renderCam, at='rotateX', v=rx, time=t)
        cmds.setKeyframe(renderCam, at='rotateY', v=ry, time=t)
        cmds.setKeyframe(renderCam, at='rotateZ', v=rz, time=t)

    debut_Matea = int(frame_fin_animation + duree_emission * 2.97) + 1
    fin_Matea = debut_Matea + 100
    
    for t, tx, ty, tz, rx, ry, rz in [(debut_Matea, 509.37, 0.602, 6.212, 7.849, 63.004, 0.827),
                                      (fin_Matea, 509.27, 0.619, 6.158, 7.849, 63.004, 0.827)]:
        cmds.setKeyframe(renderCam, at='translateX', v=tx, time=t)
        cmds.setKeyframe(renderCam, at='translateY', v=ty, time=t)
        cmds.setKeyframe(renderCam, at='translateZ', v=tz, time=t)
        cmds.setKeyframe(renderCam, at='rotateX', v=rx, time=t)
        cmds.setKeyframe(renderCam, at='rotateY', v=ry, time=t)
        cmds.setKeyframe(renderCam, at='rotateZ', v=rz, time=t)

    # Skydome Switch
    if cmds.objExists("sky_lgt"):
        try:
            if cmds.getAttr("sky_lgtShape.visibility", lock=True):
                cmds.setAttr("sky_lgtShape.visibility", lock=False)
            cmds.cutKey("sky_lgt", attribute="visibility", clear=True)
            
            cmds.setKeyframe(backSky, at="visibility", v=1, time=0)
            cmds.setKeyframe("sky_lgt", at="visibility", v=0, time=0)
            cmds.setKeyframe(backSky, at="visibility", v=0, time=debut_Matea)
            cmds.setKeyframe("sky_lgt", at="visibility", v=1, time=debut_Matea)
        except: pass

    # Decaler Papythons (si présents) - VERSION DYNAMIQUE
    if butterfly_project_name:
        # Construire les noms de groupes basés sur le nom du projet
        groupes_racine = [f"GENERATOR_{butterfly_project_name.upper()}_GRP"]
    else:
        # Fallback sur les anciens noms hardcodés
        groupes_racine = ["GENERATOR_FIRST_GROUP_GRP", "GENERATOR_SECOND_GROUPA_GRP", "GENERATOR_SECOND_GROUPB_GRP", "GENERATOR_THIRD_GROUP_GRP"]
    
    papillons = []
    for grp in groupes_racine:
        if cmds.objExists(grp):
            papillons.extend(cmds.listRelatives(grp, allDescendents=True, fullPath=True) or [])
    
    if papillons:
        anim_curves = set()
        for obj in papillons:
            curves = cmds.listConnections(obj, type="animCurve") or []
            anim_curves.update(curves)
        
        if anim_curves:
            try:
                first_key = min(cmds.keyframe(curve, query=True, timeChange=True)[0] for curve in anim_curves if cmds.keyframe(curve, q=True, tc=True))
                offset = debut_Matea - first_key
                for curve in anim_curves:
                    try: cmds.keyframe(curve, edit=True, relative=True, timeChange=offset)
                    except: pass
            except Exception as e:
                pass

    return fin_Matea

def nettoyer_scene():
    objets = ["Pages_GRP", "Pages_RIG_GRP", "Bend_GRP", "Particules_GRP", "Lights_GRP", "Camera_GRP", "shader_pages", "pagesSG", "shader_particules_magiques", "particulesSG"]
    deleted = False
    for obj in objets:
        if cmds.objExists(obj):
            try:
                cmds.delete(obj)
                deleted = True
            except: pass
    nettoyer_anciens_materials()
    return deleted


# FLIPBOOK WIDGET (VISIONNEUSE)
class FlipbookWidget(QtWidgets.QWidget):
    def __init__(self):
        super(FlipbookWidget, self).__init__()
        self.current_frame = 0
        self.images = []
        self.is_playing = False
        self.timer = QtCore.QTimer()
        self.timer.timeout.connect(self.next_frame)
        self.fps = 24
        self.init_ui()
        
    def init_ui(self):
        layout = QtWidgets.QVBoxLayout(self)
        layout.setContentsMargins(10, 10, 10, 10)
        
        self.image_label = QtWidgets.QLabel("Aucune séquence chargée")
        self.image_label.setAlignment(QtCore.Qt.AlignCenter)
        self.image_label.setStyleSheet("background-color: rgba(0, 0, 0, 150); border: 1px solid #5e4b8b; border-radius: 8px; color: #888;")
        self.image_label.setMinimumHeight(400)
        layout.addWidget(self.image_label)
        
        controls = QtWidgets.QHBoxLayout()
        
        self.btn_playblast = QtWidgets.QPushButton("GÉNÉRER PLAYBLAST")
        self.style_btn(self.btn_playblast)
        self.btn_playblast.setStyleSheet("QPushButton { background-color: rgba(100, 50, 150, 180); color: white; border: 1px solid #a080ff; font-weight: bold; border-radius: 8px; } QPushButton:hover { background-color: #a080ff; }")
        self.btn_playblast.clicked.connect(self.trigger_playblast)
        controls.addWidget(self.btn_playblast)

        self.btn_play = QtWidgets.QPushButton("▶ Lecture")
        self.style_btn(self.btn_play)
        self.btn_play.clicked.connect(self.toggle_play)
        self.btn_play.setEnabled(False)
        controls.addWidget(self.btn_play)
        
        layout.addLayout(controls)
        
        self.slider = QtWidgets.QSlider(QtCore.Qt.Horizontal)
        self.slider.setStyleSheet("QSlider::groove:horizontal { background: #2a1a4a; height: 8px; border-radius: 4px; } QSlider::handle:horizontal { background: #a080ff; width: 16px; margin: -4px 0; border-radius: 8px; }")
        self.slider.valueChanged.connect(self.set_frame)
        self.slider.setEnabled(False)
        layout.addWidget(self.slider)
        
        self.lbl_info = QtWidgets.QLabel("0 / 0")
        self.lbl_info.setAlignment(QtCore.Qt.AlignCenter)
        self.lbl_info.setStyleSheet("color: #dacce6; background: transparent;")
        layout.addWidget(self.lbl_info)

    def style_btn(self, btn):
        btn.setMinimumHeight(35)
        btn.setCursor(QtCore.Qt.PointingHandCursor)
        btn.setStyleSheet("QPushButton { background-color: rgba(60, 40, 90, 150); color: #dacce6; border: 1px solid #5e4b8b; border-radius: 8px; font-weight: bold; } QPushButton:hover { background-color: rgba(80, 50, 120, 180); color: white; }")

    def load_sequence_dialog(self):
        folder = QtWidgets.QFileDialog.getExistingDirectory(self, "Sélectionner le dossier du Playblast")
        if folder: self.load_from_path(folder)

    def trigger_playblast(self):
        parent = self.window()
        if hasattr(parent, 'run_playblast_and_view'):
            parent.run_playblast_and_view()

    def load_from_path(self, folder):
        exts = ('.jpg', '.jpeg', '.png', '.iff', '.bmp')
        self.images = [os.path.join(folder, f) for f in os.listdir(folder) if f.lower().endswith(exts)]
        self.images.sort()
        
        if self.images:
            self.current_frame = 0
            self.slider.setRange(0, len(self.images) - 1)
            self.slider.setEnabled(True)
            self.btn_play.setEnabled(True)
            self.show_frame(0)
            self.image_label.setText("")
            self.lbl_info.setText(f"Frame 1 / {len(self.images)}")
            if not self.is_playing: self.toggle_play()
        else:
            self.image_label.setText("Aucune image trouvée.")

    def toggle_play(self):
        if self.is_playing:
            self.timer.stop()
            self.btn_play.setText("▶ Lecture")
        else:
            self.timer.start(1000 / self.fps)
            self.btn_play.setText("⏸ Pause")
        self.is_playing = not self.is_playing

    def next_frame(self):
        self.current_frame += 1
        if self.current_frame >= len(self.images): self.current_frame = 0
        self.slider.setValue(self.current_frame)

    def set_frame(self, val):
        self.current_frame = val
        self.show_frame(val)

    def show_frame(self, index):
        if 0 <= index < len(self.images):
            pixmap = QtGui.QPixmap(self.images[index])
            scaled_pixmap = pixmap.scaled(self.image_label.size(), QtCore.Qt.KeepAspectRatio, QtCore.Qt.SmoothTransformation)
            self.image_label.setPixmap(scaled_pixmap)
            self.lbl_info.setText(f"Frame {index+1} / {len(self.images)}")


#  GÉNÉRATEUR DE PAPILLONS

# FONCTIONS UTILITAIRES PAPILLONS
def VecNorm(v):
    return math.sqrt(v[0]**2 + v[1]**2 + v[2]**2)

def Normalize(v):
    norm = VecNorm(v)
    if norm == 0:
        return [0, 0, 1]
    return [v[0]/norm, v[1]/norm, v[2]/norm]

def DerivVectorList(posListe):
    velListe = []
    for i in range(len(posListe)-1):
        vel = [posListe[i+1][0] - posListe[i][0],
               posListe[i+1][1] - posListe[i][1],
               posListe[i+1][2] - posListe[i][2]]
        velListe.append(vel)
    velListe.append(velListe[len(posListe)-2])
    return velListe

def FindNodeIgnoreNamespace(name, parent):
    children = cmds.listRelatives(parent, ad=True, type="transform") or []
    for node in children:
        if node.split(":")[-1] == name:
            return node
    return None

# FONCTIONS PRINCIPALES PAPILLONS
def AnimRandAtWorldCenter(controller, attToNoise, animStart, animEnd, smoothCrv, sampleCrv):
    for key in attToNoise:
        (action, attname, nbFrame, Nmin, Nmax) = key
        att = controller + "." + attname
        
        frameL = [animStart, animEnd]
        for i in range(nbFrame):
            frame = random.randint(animStart, animEnd+1)
            frameL.append(frame)
        
        for frame in frameL:
            x = random.uniform(Nmin, Nmax)
            cmds.currentTime(frame)
            action(x, x, x, controller, a=True)
            cmds.setKeyframe(att)
    
    cmds.scale(x, 1, 1, controller, a=True)
    toSmoothL = []
    for key in attToNoise:
        toSmoothL.append(controller + "_" + key[1])
    cmds.filterCurve(*toSmoothL, cof=smoothCrv, f="butterworth", sr=sampleCrv)

def CreateMotionAtWorldCenter(nbPaths, phPref, animPhPref, attToNoise, animStart, animEnd, smoothCrv, sampleCrv, rootPh):
    for i in range(nbPaths):
        number = f"{i+1:02d}"
        child = phPref + number + "_lctr"
        parent = animPhPref + number + "_ctrl"
        
        cmds.group(n=parent, em=True, w=True)
        cmds.spaceLocator(n=child)
        cmds.xform(child, ws=True, t=[1,0,0])
        cmds.parent(child, parent)
        
        AnimRandAtWorldCenter(parent, attToNoise, animStart, animEnd, smoothCrv, sampleCrv)
    
    cmds.group(n=rootPh, em=True, w=True)
    cmds.parent(cmds.ls(animPhPref + "*", type="transform"), rootPh)

def ListTargetPos(target, animStart, animEnd):
    posListe = []
    for frame in range(animStart, animEnd+1):
        cmds.currentTime(frame)
        position = cmds.xform(target, q=True, t=True, ws=True)
        posListe.append(position)
    return posListe

def FollowTarget(follower, target, late, animStart, animEnd):
    posListe = ListTargetPos(target, animStart, animEnd)
    derClefs = len(posListe) - 1
    
    for frame in range(animStart, animEnd+1):
        idx = frame - animStart - late
        if(idx < 0): idx = 0
        if(idx > derClefs - 1): idx = derClefs - 1
        
        cmds.currentTime(frame)
        cmds.move(*posListe[idx], follower)
        cmds.setKeyframe(follower, at="translate")
    
    return posListe

def PrepMesh(mesh, nameRoot, sMin, sMax):
    randS = random.uniform(sMin, sMax)
    cmds.scale(randS, randS, randS, mesh)
    cmds.group(n=nameRoot, em=True, w=True)
    cmds.parent(mesh, nameRoot)

def OrientToVel(follower, posListe, animStart, animEnd):
    velListe = DerivVectorList(posListe)
    
    for frame in range(animStart, animEnd+1):
        idx = frame - animStart
        cmds.currentTime(frame)
        
        vel = velListe[idx]
        dirVel = Normalize(vel)
        
        rotX = -math.atan2(dirVel[1], math.sqrt(dirVel[0]**2 + dirVel[2]**2))
        rotY = math.atan2(dirVel[0], dirVel[2])
        
        rotX = math.degrees(rotX)
        rotY = math.degrees(rotY)
        rotZ = 0
        
        cmds.rotate(rotX, rotY, rotZ, follower, a=True)
        cmds.setKeyframe(follower, at="rotate")
    
    return velListe

def AnimWingsToAcc(accListe, wingMesh, isRight, angleMin, angleMax, animStart, animEnd, accThreshold, wingSpeed):
    bottom = angleMin
    top = angleMax
    if(isRight):
        bottom = -bottom
        top = -top
    
    frame = animStart
    while(frame < animEnd + 1):
        acc = VecNorm(accListe[frame - animStart])
        
        if(acc < accThreshold):
            frame += 1
        else:
            isTop = True
            while(acc > accThreshold and frame < animEnd + 1):
                cmds.currentTime(frame)
                if(isTop):
                    cmds.rotate(0, top, 0, wingMesh, a=True)
                else:
                    cmds.rotate(0, bottom, 0, wingMesh, a=True)
                cmds.setKeyframe(wingMesh, at="rotate")
                
                frame += wingSpeed + random.randint(-2, 1)
                isTop = not isTop
                
                if(frame < animEnd + 1):
                    acc = VecNorm(accListe[frame - animStart])
            
            cmds.currentTime(frame)
            cmds.rotate(0, 0, 0, wingMesh, a=True)
            cmds.setKeyframe(wingMesh, at="rotate")
            frame += 1

def BakeToMesh(hasWings, phPref, geoMshPref, animMshPref, meshToGenerate, animStart, animEnd, RWing, LWing, mainGn, angleMin, angleMax, accThreshold, wingSpeed, sMin, sMax):
    targetList = cmds.ls(phPref + "*", type="transform")
    
    for i in range(len(targetList)):
        target = targetList[i]
        number = f"{i+1:02d}"
        nameMode = geoMshPref + number + "_grp"
        nameAnim = animMshPref + number + "_ctrl"
        
        cmds.duplicate(meshToGenerate, n=nameMode)
        PrepMesh(nameMode, nameAnim, sMin, sMax)
        
        posListe = FollowTarget(nameAnim, target, 0, animStart, animEnd)
        velListe = OrientToVel(nameAnim, posListe, animStart, animEnd)
        
        if(hasWings):
            accListe = DerivVectorList(velListe)
            
            tofind = nameMode + "|" + RWing
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToAcc(accListe, wingMesh, False, angleMin, angleMax, animStart, animEnd, accThreshold, wingSpeed)
            
            tofind = nameMode + "|" + LWing
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToAcc(accListe, wingMesh, True, angleMin, angleMax, animStart, animEnd, accThreshold, wingSpeed)
    
    cmds.parent(cmds.ls(animMshPref + "*", type='transform'), mainGn)

def generer_papillons(project_name, nb_bugs, target_name, mesh_name, lwing_name, rwing_name, 
                     rotation_noise_freq, dist_noise_freq, dist_min, dist_max,
                     cutoff_freq, sampling_rate, frame_delay,
                     mesh_scale_min, mesh_scale_max, animate_wings,
                     accel_threshold, wing_duration, wing_down_angle, wing_up_angle):
    
    # Désactiver autokey
    autokey = bool(mel.eval('autoKeyframe -q -state;'))
    mel.eval("autoKeyframe -state 0;")
    
    try:
        # Noms
        mainGn = "GENERATOR_" + project_name.upper() + "_GRP"
        phPref = project_name + "_placeHolder"
        animPhPref = project_name + "_anim_placeHolder"
        rootPh = project_name + "_root_placeHolders_ctrl"
        geoMshPref = project_name + "_geo"
        animMshPref = project_name + "_anim_mesh"
        
        # Frames fixes
        animStart = 101
        animEnd = 221
        fps = 24
        
        # Cleanup
        if cmds.objExists(mainGn):
            cmds.delete(mainGn)
        cmds.group(n=mainGn, em=True, w=True)
        
        # Calcul des noises
        rNbFrames = int((animEnd - animStart) / fps * rotation_noise_freq)
        sNbFrames = int((animEnd - animStart) / fps * dist_noise_freq)
        
        attToNoise = [[cmds.rotate, "rotateX", rNbFrames, -180, 180],
                      [cmds.rotate, "rotateY", rNbFrames, -180, 180],
                      [cmds.rotate, "rotateZ", rNbFrames, -180, 180],
                      [cmds.scale, "scaleX", sNbFrames, dist_min, dist_max]]
        
        # Création motion
        CreateMotionAtWorldCenter(nb_bugs, phPref, animPhPref, attToNoise, animStart, animEnd, cutoff_freq, sampling_rate, rootPh)
        
        # Follow target
        FollowTarget(rootPh, target_name, frame_delay, animStart, animEnd)
        
        # Bake mesh
        BakeToMesh(animate_wings, phPref, geoMshPref, animMshPref, mesh_name, animStart, animEnd, 
                  rwing_name, lwing_name, mainGn, wing_down_angle, wing_up_angle, 
                  accel_threshold, wing_duration, mesh_scale_min, mesh_scale_max)
        
        # Cleanup final
        cmds.parent(rootPh, mainGn)
        cmds.hide(rootPh)
        
        return True, project_name
        
    except Exception as e:
        return False, None
        return False, str(e)
    
    finally:
        if(autokey):
            mel.eval("autoKeyframe -state 1;")


# INTERFACE GRAPHIQUE
class MagicGrimoireUI(QtWidgets.QDialog):
    def __init__(self):
        super(MagicGrimoireUI, self).__init__()
        
        self.setWindowTitle("MAJIA Project")
        self.setWindowFlags(QtCore.Qt.Window | QtCore.Qt.FramelessWindowHint)
        self.setAttribute(QtCore.Qt.WA_TranslucentBackground)
        self.setFixedSize(600, 750) 
        
        self.dragPos = QtCore.QPoint()
        
        # Etoiles procédurales
        random.seed(42)
        self.stars = []
        for _ in range(80):
            self.stars.append((random.randint(0, 600), random.randint(0, 750), random.randint(1, 3), random.randint(50, 200)))
        random.seed()
            
        self.couleur_particules = (1.0, 0.84, 0.0) 
        self.textures_folder = ""
        self.textures_list = {}
        self.scene_path = ""
        self.butterfly_project_name = ""

        self.init_ui()

    def paintEvent(self, event):
        painter = QtGui.QPainter(self)
        painter.setRenderHint(QtGui.QPainter.Antialiasing)
        rect_path = QtGui.QPainterPath()
        rect_path.addRoundedRect(10, 10, self.width()-20, self.height()-20, 25, 25)
        
        gradient = QtGui.QLinearGradient(0, 0, 0, self.height())
        gradient.setColorAt(0.0, QtGui.QColor(60, 30, 90, 255)) 
        gradient.setColorAt(1.0, QtGui.QColor(20, 10, 40, 255)) 
        
        painter.fillPath(rect_path, gradient)
        painter.setPen(QtCore.Qt.NoPen)
        for x, y, s, o in self.stars:
            painter.setBrush(QtGui.QColor(255, 255, 200, o))
            painter.drawEllipse(x, y, s, s)
        pen = QtGui.QPen(QtGui.QColor(160, 130, 255), 3)
        painter.setPen(pen)
        painter.drawPath(rect_path)

    def mousePressEvent(self, event):
        self.dragPos = event.globalPos()

    def mouseMoveEvent(self, event):
        if event.buttons() == QtCore.Qt.LeftButton:
            self.move(self.pos() + event.globalPos() - self.dragPos)
            self.dragPos = event.globalPos()
            event.accept()

    def init_ui(self):
        main_layout = QtWidgets.QVBoxLayout(self)
        main_layout.setContentsMargins(40, 50, 40, 40)
        
        title = QtWidgets.QLabel("MAJIA")
        title.setAlignment(QtCore.Qt.AlignCenter)
        title.setStyleSheet("QLabel { font-family: 'Georgia', serif; font-size: 36px; font-weight: bold; color: #ffffff; letter-spacing: 5px; background: transparent; }")
        main_layout.addWidget(title)
        
        close_btn = QtWidgets.QPushButton("X", self)
        close_btn.setGeometry(self.width()-40, 20, 25, 25)
        close_btn.setCursor(QtCore.Qt.PointingHandCursor)
        close_btn.setStyleSheet("background: transparent; color: #a080ff; font-weight: bold; border: none; font-size: 16px;")
        close_btn.clicked.connect(self.close)

        main_layout.addSpacing(20)

        # Tabs
        nav_layout = QtWidgets.QHBoxLayout()
        nav_layout.setSpacing(10)
        self.btn_grimoire = self.create_nav_button("GRIMOIRE")
        self.btn_scenes = self.create_nav_button("PAPILLONS")
        self.btn_particles = self.create_nav_button("PARTICULES")
        self.btn_preview = self.create_nav_button("VISIONNEUSE")
        nav_layout.addWidget(self.btn_grimoire)
        nav_layout.addWidget(self.btn_scenes)
        nav_layout.addWidget(self.btn_particles)
        nav_layout.addWidget(self.btn_preview)
        main_layout.addLayout(nav_layout)
        main_layout.addSpacing(20)

        # Content
        self.stack = QtWidgets.QStackedWidget()
        self.page_grimoire = self.setup_grimoire_page()
        self.stack.addWidget(self.page_grimoire)
        self.page_scenes = self.setup_butterflies_page()
        self.stack.addWidget(self.page_scenes)
        self.page_particles = self.setup_particles_page()
        self.stack.addWidget(self.page_particles)
        self.page_preview = FlipbookWidget()
        self.stack.addWidget(self.page_preview)
        main_layout.addWidget(self.stack)

        # Footer
        footer_layout = QtWidgets.QHBoxLayout()
        self.btn_anim = QtWidgets.QPushButton("LANCER LA MAGIE")
        self.apply_action_style(self.btn_anim, is_primary=True)
        self.btn_anim.clicked.connect(self.run_animation_logic)
        self.btn_delete = QtWidgets.QPushButton("RESET")
        self.apply_action_style(self.btn_delete, is_primary=False)
        self.btn_delete.clicked.connect(self.supprimer_tout)
        footer_layout.addWidget(self.btn_delete)
        footer_layout.addWidget(self.btn_anim)
        main_layout.addSpacing(10)
        main_layout.addLayout(footer_layout)

        self.btn_grimoire.clicked.connect(lambda: self.set_active_tab(0))
        self.btn_scenes.clicked.connect(lambda: self.set_active_tab(1))
        self.btn_particles.clicked.connect(lambda: self.set_active_tab(2))
        self.btn_preview.clicked.connect(lambda: self.set_active_tab(3))
        self.set_active_tab(0)

    def set_active_tab(self, index):
        self.stack.setCurrentIndex(index)
        btns = [self.btn_grimoire, self.btn_scenes, self.btn_particles, self.btn_preview]
        for i, btn in enumerate(btns):
            if i == index: btn.setStyleSheet(self.get_nav_style(active=True))
            else: btn.setStyleSheet(self.get_nav_style(active=False))

    # PAGES SETUP
    def setup_grimoire_page(self):
        page = QtWidgets.QWidget()
        main_layout = QtWidgets.QVBoxLayout(page)
        main_layout.setContentsMargins(0, 0, 0, 0)
        
        scroll = QtWidgets.QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QtWidgets.QFrame.NoFrame)
        scroll.setStyleSheet("QScrollArea { background: transparent; border: none; } QScrollBar:vertical { background: rgba(30, 15, 50, 100); width: 12px; border-radius: 6px; } QScrollBar::handle:vertical { background: rgba(160, 130, 255, 150); border-radius: 6px; min-height: 20px; }")
        
        content_widget = QtWidgets.QWidget()
        layout = QtWidgets.QVBoxLayout(content_widget)
        layout.setSpacing(15)
        layout.setContentsMargins(10, 10, 10, 10)
        
        # Scene
        grp_scene = self.create_group_box("Scène Maya")
        l_scene = QtWidgets.QVBoxLayout()
        l_scene.addWidget(self.create_label("Ouvrir une scène :"))
        self.btn_scene = QtWidgets.QPushButton("Sélectionner une scène Maya")
        self.btn_scene.setMinimumHeight(40)
        self.btn_scene.setStyleSheet("QPushButton { background-color: rgba(60, 40, 90, 150); color: #dacce6; border: 1px solid #5e4b8b; border-radius: 8px; font-weight: bold; }")
        self.btn_scene.clicked.connect(self.ouvrir_scene_maya)
        l_scene.addWidget(self.btn_scene)
        self.label_scene = self.create_label("Aucune scène ouverte")
        self.label_scene.setStyleSheet("color: #888; font-size: 11px; font-style: italic; background: transparent;")
        l_scene.addWidget(self.label_scene)
        grp_scene.setLayout(l_scene)
        layout.addWidget(grp_scene)

        # Pages
        grp_pages = self.create_group_box("Configuration du Livre")
        l_pages = QtWidgets.QVBoxLayout()
        l_pages.addWidget(self.create_label("Nombre total de pages :"))
        self.spin_pages = self.create_spinbox(10, 100, 50)
        self.spin_pages.valueChanged.connect(self.update_max_pages_tournees)
        l_pages.addWidget(self.spin_pages)
        l_pages.addWidget(self.create_label("Pages qui s'animent :"))
        self.spin_pages_tournees = self.create_spinbox(5, 50, 24)
        l_pages.addWidget(self.spin_pages_tournees)
        l_pages.addWidget(self.create_label("Textures des pages (Dossier) :"))
        self.btn_textures = QtWidgets.QPushButton("Sélectionner un dossier")
        self.btn_textures.setMinimumHeight(40)
        self.btn_textures.setStyleSheet("QPushButton { background-color: rgba(60, 40, 90, 150); color: #dacce6; border: 1px solid #5e4b8b; border-radius: 8px; font-weight: bold; }")
        self.btn_textures.clicked.connect(self.choisir_dossier_textures)
        l_pages.addWidget(self.btn_textures)
        self.label_textures = self.create_label("Aucun dossier sélectionné (Pages blanches)")
        self.label_textures.setStyleSheet("color: #888; font-size: 11px; font-style: italic; background: transparent;")
        l_pages.addWidget(self.label_textures)
        grp_pages.setLayout(l_pages)
        layout.addWidget(grp_pages)

        # Time
        grp_time = self.create_group_box("Timeline")
        l_time = QtWidgets.QVBoxLayout()
        l_time.addWidget(self.create_label("Durée totale (frames) :"))
        self.spin_temps_total = self.create_spinbox(100, 1000, 300)
        self.spin_temps_total.valueChanged.connect(self.update_max_pages_tournees)
        l_time.addWidget(self.spin_temps_total)
        l_time.addWidget(self.create_label("Start Frame :"))
        self.spin_frame_debut = self.create_spinbox(1, 100, 35)
        self.spin_frame_debut.valueChanged.connect(self.update_max_pages_tournees)
        l_time.addWidget(self.spin_frame_debut)
        grp_time.setLayout(l_time)
        layout.addWidget(grp_time)
        
        layout.addStretch()
        scroll.setWidget(content_widget)
        main_layout.addWidget(scroll)
        return page

    def setup_butterflies_page(self):
        page = QtWidgets.QWidget()
        main_layout = QtWidgets.QVBoxLayout(page)
        main_layout.setContentsMargins(0, 0, 0, 0)
        
        scroll = QtWidgets.QScrollArea()
        scroll.setWidgetResizable(True)
        scroll.setFrameShape(QtWidgets.QFrame.NoFrame)
        scroll.setStyleSheet("QScrollArea { background: transparent; border: none; } QScrollBar:vertical { background: rgba(30, 15, 50, 100); width: 12px; border-radius: 6px; } QScrollBar::handle:vertical { background: rgba(160, 130, 255, 150); border-radius: 6px; min-height: 20px; }")
        
        content_widget = QtWidgets.QWidget()
        layout = QtWidgets.QVBoxLayout(content_widget)
        layout.setSpacing(15)
        layout.setContentsMargins(10, 10, 10, 10)
        
        # Général
        grp_general = self.create_group_box("Configuration Générale")
        l_general = QtWidgets.QVBoxLayout()
        l_general.addWidget(self.create_label("Nom du Projet :"))
        self.txt_butterfly_project = QtWidgets.QLineEdit("second_groupB")
        self.txt_butterfly_project.setMinimumHeight(40)
        self.txt_butterfly_project.setStyleSheet(self.get_input_style())
        l_general.addWidget(self.txt_butterfly_project)
        
        l_general.addWidget(self.create_label("Nombre de Papillons :"))
        self.spin_nb_bugs = self.create_spinbox(1, 20, 1)
        l_general.addWidget(self.spin_nb_bugs)
        
        l_general.addWidget(self.create_label("Target à suivre :"))
        self.txt_butterfly_target = QtWidgets.QLineEdit("papython_target_lctr")
        self.txt_butterfly_target.setMinimumHeight(40)
        self.txt_butterfly_target.setStyleSheet(self.get_input_style())
        l_general.addWidget(self.txt_butterfly_target)
        grp_general.setLayout(l_general)
        layout.addWidget(grp_general)
        
        # Mesh
        grp_mesh = self.create_group_box("Configuration Mesh")
        l_mesh = QtWidgets.QVBoxLayout()
        l_mesh.addWidget(self.create_label("Mesh/Groupe Mesh :"))
        self.txt_butterfly_mesh = QtWidgets.QLineEdit("pp:papython_grp")
        self.txt_butterfly_mesh.setMinimumHeight(40)
        self.txt_butterfly_mesh.setStyleSheet(self.get_input_style())
        l_mesh.addWidget(self.txt_butterfly_mesh)
        
        l_mesh.addWidget(self.create_label("Scale Min :"))
        self.spin_butterfly_scale_min = QtWidgets.QDoubleSpinBox()
        self.spin_butterfly_scale_min.setRange(0.0, 5.0)
        self.spin_butterfly_scale_min.setValue(0.035)
        self.spin_butterfly_scale_min.setSingleStep(0.01)
        self.spin_butterfly_scale_min.setDecimals(3)
        self.spin_butterfly_scale_min.setMinimumHeight(40)
        self.spin_butterfly_scale_min.setStyleSheet(self.get_input_style())
        l_mesh.addWidget(self.spin_butterfly_scale_min)
        
        l_mesh.addWidget(self.create_label("Scale Max :"))
        self.spin_butterfly_scale_max = QtWidgets.QDoubleSpinBox()
        self.spin_butterfly_scale_max.setRange(0.0, 5.0)
        self.spin_butterfly_scale_max.setValue(0.125)
        self.spin_butterfly_scale_max.setSingleStep(0.01)
        self.spin_butterfly_scale_max.setDecimals(3)
        self.spin_butterfly_scale_max.setMinimumHeight(40)
        self.spin_butterfly_scale_max.setStyleSheet(self.get_input_style())
        l_mesh.addWidget(self.spin_butterfly_scale_max)
        grp_mesh.setLayout(l_mesh)
        layout.addWidget(grp_mesh)
        
        # Mouvement
        grp_movement = self.create_group_box("Mouvement Aléatoire")
        l_movement = QtWidgets.QVBoxLayout()
        
        l_movement.addWidget(self.create_label("Rotation Noise Freq :"))
        self.spin_rotation_noise = QtWidgets.QDoubleSpinBox()
        self.spin_rotation_noise.setRange(0.001, 10.0)
        self.spin_rotation_noise.setValue(1.75)
        self.spin_rotation_noise.setSingleStep(0.1)
        self.spin_rotation_noise.setDecimals(3)
        self.spin_rotation_noise.setMinimumHeight(40)
        self.spin_rotation_noise.setStyleSheet(self.get_input_style())
        l_movement.addWidget(self.spin_rotation_noise)
        
        l_movement.addWidget(self.create_label("Distance Noise Freq :"))
        self.spin_dist_noise = QtWidgets.QDoubleSpinBox()
        self.spin_dist_noise.setRange(0.001, 10.0)
        self.spin_dist_noise.setValue(1.75)
        self.spin_dist_noise.setSingleStep(0.1)
        self.spin_dist_noise.setDecimals(3)
        self.spin_dist_noise.setMinimumHeight(40)
        self.spin_dist_noise.setStyleSheet(self.get_input_style())
        l_movement.addWidget(self.spin_dist_noise)
        
        l_movement.addWidget(self.create_label("Distance Min :"))
        self.spin_dist_min = QtWidgets.QDoubleSpinBox()
        self.spin_dist_min.setRange(0.0, 100.0)
        self.spin_dist_min.setValue(0.25)
        self.spin_dist_min.setSingleStep(0.1)
        self.spin_dist_min.setDecimals(3)
        self.spin_dist_min.setMinimumHeight(40)
        self.spin_dist_min.setStyleSheet(self.get_input_style())
        l_movement.addWidget(self.spin_dist_min)
        
        l_movement.addWidget(self.create_label("Distance Max :"))
        self.spin_dist_max = QtWidgets.QDoubleSpinBox()
        self.spin_dist_max.setRange(0.0, 100.0)
        self.spin_dist_max.setValue(0.75)
        self.spin_dist_max.setSingleStep(0.1)
        self.spin_dist_max.setDecimals(3)
        self.spin_dist_max.setMinimumHeight(40)
        self.spin_dist_max.setStyleSheet(self.get_input_style())
        l_movement.addWidget(self.spin_dist_max)
        
        l_movement.addWidget(self.create_label("Cutoff Frequency :"))
        self.spin_cutoff = QtWidgets.QDoubleSpinBox()
        self.spin_cutoff.setRange(0.0, 30.0)
        self.spin_cutoff.setValue(2.5)
        self.spin_cutoff.setSingleStep(0.1)
        self.spin_cutoff.setDecimals(3)
        self.spin_cutoff.setMinimumHeight(40)
        self.spin_cutoff.setStyleSheet(self.get_input_style())
        l_movement.addWidget(self.spin_cutoff)
        
        l_movement.addWidget(self.create_label("Sampling Rate :"))
        self.spin_sampling = QtWidgets.QDoubleSpinBox()
        self.spin_sampling.setRange(1.0, 100.0)
        self.spin_sampling.setValue(6.0)
        self.spin_sampling.setSingleStep(0.5)
        self.spin_sampling.setDecimals(3)
        self.spin_sampling.setMinimumHeight(40)
        self.spin_sampling.setStyleSheet(self.get_input_style())
        l_movement.addWidget(self.spin_sampling)
        
        l_movement.addWidget(self.create_label("Frame Delay :"))
        self.spin_frame_delay = self.create_spinbox(0, 100, 14)
        l_movement.addWidget(self.spin_frame_delay)
        grp_movement.setLayout(l_movement)
        layout.addWidget(grp_movement)
        
        # Ailes
        grp_wings = self.create_group_box("Animation des Ailes")
        l_wings = QtWidgets.QVBoxLayout()
        
        self.chk_animate_wings = QtWidgets.QCheckBox("Animer les ailes")
        self.chk_animate_wings.setChecked(True)
        self.chk_animate_wings.setStyleSheet("QCheckBox { color: #bfa6d9; font-size: 12px; background: transparent; } QCheckBox::indicator { width: 18px; height: 18px; }")
        l_wings.addWidget(self.chk_animate_wings)
        
        l_wings.addWidget(self.create_label("Aile Gauche :"))
        self.txt_lwing = QtWidgets.QLineEdit("L_wing_msh")
        self.txt_lwing.setMinimumHeight(40)
        self.txt_lwing.setStyleSheet(self.get_input_style())
        l_wings.addWidget(self.txt_lwing)
        
        l_wings.addWidget(self.create_label("Aile Droite :"))
        self.txt_rwing = QtWidgets.QLineEdit("R_wing_msh")
        self.txt_rwing.setMinimumHeight(40)
        self.txt_rwing.setStyleSheet(self.get_input_style())
        l_wings.addWidget(self.txt_rwing)
        
        l_wings.addWidget(self.create_label("Accel Threshold :"))
        self.spin_accel_threshold = QtWidgets.QDoubleSpinBox()
        self.spin_accel_threshold.setRange(0.0, 10.0)
        self.spin_accel_threshold.setValue(0.615)
        self.spin_accel_threshold.setSingleStep(0.01)
        self.spin_accel_threshold.setDecimals(3)
        self.spin_accel_threshold.setMinimumHeight(40)
        self.spin_accel_threshold.setStyleSheet(self.get_input_style())
        l_wings.addWidget(self.spin_accel_threshold)
        
        l_wings.addWidget(self.create_label("Wing Duration :"))
        self.spin_wing_duration = self.create_spinbox(1, 20, 4)
        l_wings.addWidget(self.spin_wing_duration)
        
        l_wings.addWidget(self.create_label("Wings Down Angle :"))
        self.spin_wing_down = QtWidgets.QDoubleSpinBox()
        self.spin_wing_down.setRange(-180.0, 0.0)
        self.spin_wing_down.setValue(-65.0)
        self.spin_wing_down.setSingleStep(1.0)
        self.spin_wing_down.setDecimals(3)
        self.spin_wing_down.setMinimumHeight(40)
        self.spin_wing_down.setStyleSheet(self.get_input_style())
        l_wings.addWidget(self.spin_wing_down)
        
        l_wings.addWidget(self.create_label("Wings Up Angle :"))
        self.spin_wing_up = QtWidgets.QDoubleSpinBox()
        self.spin_wing_up.setRange(0.0, 180.0)
        self.spin_wing_up.setValue(50.0)
        self.spin_wing_up.setSingleStep(1.0)
        self.spin_wing_up.setDecimals(3)
        self.spin_wing_up.setMinimumHeight(40)
        self.spin_wing_up.setStyleSheet(self.get_input_style())
        l_wings.addWidget(self.spin_wing_up)
        grp_wings.setLayout(l_wings)
        layout.addWidget(grp_wings)
        
        # Bouton de génération
        btn_gen_butterflies = QtWidgets.QPushButton("GÉNÉRER LES PAPILLONS")
        self.apply_action_style(btn_gen_butterflies, is_primary=True)
        btn_gen_butterflies.clicked.connect(self.generer_papillons_action)
        layout.addWidget(btn_gen_butterflies)
        
        layout.addStretch()
        scroll.setWidget(content_widget)
        main_layout.addWidget(scroll)
        return page

    def setup_particles_page(self):
        page = QtWidgets.QWidget()
        main_layout = QtWidgets.QVBoxLayout(page)
        main_layout.setContentsMargins(10, 10, 10, 10)
        
        grp_part = self.create_group_box("Système de Particules")
        l_part = QtWidgets.QVBoxLayout()
        l_part.addWidget(self.create_label("Débit (particules/sec) :"))
        self.spin_nb_particules = self.create_spinbox(50, 1000, 200)
        l_part.addWidget(self.spin_nb_particules)
        l_part.addWidget(self.create_label("Durée émission (frames) :"))
        self.spin_duree_emission = self.create_spinbox(20, 200, 60)
        l_part.addWidget(self.spin_duree_emission)
        l_part.addWidget(self.create_label("Force du Vortex :"))
        self.spin_force_vortex = QtWidgets.QDoubleSpinBox()
        self.spin_force_vortex.setRange(0.0, 20.0)
        self.spin_force_vortex.setValue(5.0)
        self.spin_force_vortex.setSingleStep(0.5)
        self.spin_force_vortex.setMinimumHeight(40)
        self.spin_force_vortex.setStyleSheet(self.get_input_style())
        l_part.addWidget(self.spin_force_vortex)
        l_part.addWidget(self.create_label("Couleur Magique :"))
        self.btn_couleur = QtWidgets.QPushButton("Changer Couleur")
        self.btn_couleur.setMinimumHeight(40)
        self.btn_couleur.clicked.connect(self.choisir_couleur)
        self.update_color_btn_style((255, 215, 0))
        l_part.addWidget(self.btn_couleur)
        grp_part.setLayout(l_part)
        
        main_layout.addWidget(grp_part)
        main_layout.addStretch()
        return page

    # UI HELPERS
    def create_nav_button(self, text):
        btn = QtWidgets.QPushButton(text)
        btn.setMinimumHeight(40)
        btn.setCursor(QtCore.Qt.PointingHandCursor)
        btn.setStyleSheet(self.get_nav_style(False))
        return btn

    def get_nav_style(self, active):
        if active:
            return "QPushButton { background-color: rgba(160, 130, 255, 150); color: white; border: 2px solid #fff; border-radius: 10px; font-weight: bold; font-family: 'Segoe UI'; }"
        else:
            return "QPushButton { background-color: rgba(40, 20, 60, 100); color: #aaa; border: 1px solid #5e4b8b; border-radius: 10px; font-weight: bold; font-family: 'Segoe UI'; } QPushButton:hover { background-color: rgba(80, 50, 120, 150); color: #fff; }"

    def apply_action_style(self, btn, is_primary):
        btn.setMinimumHeight(50)
        btn.setCursor(QtCore.Qt.PointingHandCursor)
        if is_primary:
            btn.setStyleSheet("QPushButton { background: qlineargradient(x1:0, y1:0, x2:1, y2:0, stop:0 #7a4bc4, stop:1 #a080ff); color: white; border: 2px solid #dcd0ff; border-radius: 25px; font-size: 14px; font-weight: bold; letter-spacing: 1px; } QPushButton:hover { background: #bda0ff; border-color: #fff; } QPushButton:pressed { background: #5e3096; padding-top: 2px; }")
        else:
            btn.setStyleSheet("QPushButton { background-color: rgba(0,0,0,50); color: #888; border: 1px solid #444; border-radius: 25px; } QPushButton:hover { color: #ff6666; border-color: #ff6666; }")

    def create_group_box(self, title):
        grp = QtWidgets.QGroupBox(title)
        grp.setStyleSheet("QGroupBox { border: 1px solid #5e4b8b; border-radius: 10px; margin-top: 20px; background-color: rgba(30, 15, 50, 100); } QGroupBox::title { subcontrol-origin: margin; left: 15px; padding: 0 5px; color: #dacce6; font-weight: bold; }")
        return grp

    def create_label(self, text):
        lbl = QtWidgets.QLabel(text)
        lbl.setStyleSheet("color: #bfa6d9; font-size: 12px; margin-bottom: 2px; background: transparent;")
        return lbl

    def get_input_style(self):
        return "background-color: rgba(20, 10, 30, 150); color: white; border: 1px solid #5e4b8b; border-radius: 5px; padding-left: 10px; selection-background-color: #a080ff;"

    def create_spinbox(self, min_v, max_v, val):
        spin = QtWidgets.QSpinBox()
        spin.setRange(min_v, max_v)
        spin.setValue(val)
        spin.setMinimumHeight(40)
        spin.setStyleSheet("QSpinBox {" + self.get_input_style() + "}")
        return spin
    
    def update_color_btn_style(self, rgb_tuple):
        r, g, b = rgb_tuple
        self.btn_couleur.setStyleSheet(f"QPushButton {{ background-color: rgba({r}, {g}, {b}, 200); border: 2px solid #fff; border-radius: 8px; color: {'#000' if (r+g+b)/3 > 128 else '#fff'}; font-weight: bold; }}")

    # --- LOGIQUE MÉTIER ---
    def choisir_couleur(self):
        color = QtWidgets.QColorDialog.getColor()
        if color.isValid():
            self.couleur_particules = (color.redF(), color.greenF(), color.blueF())
            self.update_color_btn_style((color.red(), color.green(), color.blue()))
    
    def choisir_dossier_textures(self):
        folder = QtWidgets.QFileDialog.getExistingDirectory(self, "Sélectionner le dossier de textures")
        if folder:
            self.textures_folder = folder
            files = [f for f in os.listdir(folder) if f.lower().endswith(('.png', '.jpg', '.jpeg', '.tif', '.exr'))]
            files.sort()
            
            # Map auto des textures
            self.textures_list = {}
            # Chercher Matea
            matea_f = next((f for f in files if "matea" in f.lower()), None)
            if matea_f: self.textures_list["pageMatea"] = os.path.join(folder, matea_f)
            elif len(files) >= 4: self.textures_list["pageMatea"] = os.path.join(folder, files[3])
            
            # Chercher 01, 02, 03
            for i in range(1, 4):
                key = f"page0{i}"
                found = next((f for f in files if f"0{i}" in f or f"page{i}" in f.lower()), None)
                if found: self.textures_list[key] = os.path.join(folder, found)
                elif len(files) >= i: self.textures_list[key] = os.path.join(folder, files[i-1])

            if self.textures_list:
                self.label_textures.setText(f"{len(self.textures_list)} textures chargées")
                self.label_textures.setStyleSheet("color: #90d090; font-size: 11px; font-style: italic; background: transparent;")
            else:
                self.label_textures.setText("Aucune texture valide trouvée")

    def ouvrir_scene_maya(self):
        scene_file, _ = QtWidgets.QFileDialog.getOpenFileName(self, "Ouvrir", "", "Maya Scenes (*.ma *.mb)")
        if scene_file:
            try:
                cmds.file(scene_file, open=True, force=True)
                self.label_scene.setText(os.path.basename(scene_file))
                self.label_scene.setStyleSheet("color: #90d090; font-size: 11px; font-style: italic; background: transparent;")
            except Exception as e:
                self.label_scene.setText("Erreur ouverture")

    def update_max_pages_tournees(self):
        temps_total = self.spin_temps_total.value()
        frame_debut = self.spin_frame_debut.value()
        nombre_pages = self.spin_pages.value()
        temps_min = 4
        temps_dispo = temps_total - frame_debut
        max_possible = max(1, min(temps_dispo // temps_min, nombre_pages - 1))
        self.spin_pages_tournees.setMaximum(max_possible)
        if self.spin_pages_tournees.value() > max_possible:
            self.spin_pages_tournees.setValue(max_possible)

    def generer_papillons_action(self):
        """Génère les papillons avec les paramètres de l'interface"""
        try:
            success, result = generer_papillons(
                project_name=self.txt_butterfly_project.text(),
                nb_bugs=self.spin_nb_bugs.value(),
                target_name=self.txt_butterfly_target.text(),
                mesh_name=self.txt_butterfly_mesh.text(),
                lwing_name=self.txt_lwing.text(),
                rwing_name=self.txt_rwing.text(),
                rotation_noise_freq=self.spin_rotation_noise.value(),
                dist_noise_freq=self.spin_dist_noise.value(),
                dist_min=self.spin_dist_min.value(),
                dist_max=self.spin_dist_max.value(),
                cutoff_freq=self.spin_cutoff.value(),
                sampling_rate=self.spin_sampling.value(),
                frame_delay=self.spin_frame_delay.value(),
                mesh_scale_min=self.spin_butterfly_scale_min.value(),
                mesh_scale_max=self.spin_butterfly_scale_max.value(),
                animate_wings=self.chk_animate_wings.isChecked(),
                accel_threshold=self.spin_accel_threshold.value(),
                wing_duration=self.spin_wing_duration.value(),
                wing_down_angle=self.spin_wing_down.value(),
                wing_up_angle=self.spin_wing_up.value()
            )
            
            if success:
                self.butterfly_project_name = result
                cmds.inViewMessage(amg='<hl>Papillons générés !</hl>', pos='midCenter', fade=True)
            else:
                cmds.inViewMessage(amg=f'<hl>Erreur: {result}</hl>', pos='midCenter', fade=True)
                
        except Exception as e:
            import traceback
            traceback.print_exc()
            cmds.inViewMessage(amg=f'<hl>Erreur: {str(e)}</hl>', pos='midCenter', fade=True)

    def supprimer_tout(self):
        nettoyer_scene()

    def run_playblast_and_view(self):
        import shutil
        workspace = cmds.workspace(q=True, rd=True)
        temp_dir = os.path.join(workspace, "majia_playblast_temp")
        if os.path.exists(temp_dir): shutil.rmtree(temp_dir)
        os.makedirs(temp_dir)
        
        model_panel = None
        panels = cmds.getPanel(visiblePanels=True)
        for p in panels:
            if cmds.getPanel(typeOf=p) == 'modelPanel':
                model_panel = p
                break
        
        if not model_panel:
            cmds.warning("Aucun viewport 3D trouvé.")
            return

        cam_name = "renderCamera1"
        if not cmds.objExists(cam_name):
            if cmds.objExists("renderCamera"): cam_name = "renderCamera"
            else:
                cmds.warning("Caméra introuvable.")
                return

        try:
            cmds.modelEditor(model_panel, e=True, allObjects=True)
            cmds.modelEditor(model_panel, e=True, nurbsCurves=False)
            cmds.modelEditor(model_panel, e=True, locators=False)
            cmds.modelEditor(model_panel, e=True, joints=False)
            cmds.modelEditor(model_panel, e=True, lights=False)
            cmds.modelEditor(model_panel, e=True, cameras=False)
            cmds.modelEditor(model_panel, e=True, ikHandles=False)
            cmds.modelEditor(model_panel, e=True, deformers=False)
            cmds.modelEditor(model_panel, e=True, grid=False)
            cmds.modelEditor(model_panel, e=True, headsUpDisplay=False)
            cmds.modelEditor(model_panel, e=True, polymeshes=True)
            cmds.modelEditor(model_panel, e=True, dynamics=True)
            cmds.modelEditor(model_panel, e=True, nParticles=True)
            cmds.modelEditor(model_panel, e=True, displayTextures=True)
            cmds.modelEditor(model_panel, e=True, displayLights='default')
            cmds.modelEditor(model_panel, e=True, shadows=False)
            cmds.lookThru(model_panel, cam_name)
            cmds.setFocus(model_panel)
            
            filename = os.path.join(temp_dir, "seq").replace("\\", "/")
            start_frame = cmds.playbackOptions(q=True, minTime=True)
            end_frame = cmds.playbackOptions(q=True, maxTime=True)
            
            cmds.playblast(
                format="image",
                filename=filename,
                sequenceTime=0,
                clearCache=1,
                viewer=0,
                showOrnaments=0,
                fp=4,
                percent=100,
                compression="jpg",
                quality=100,
                widthHeight=[960, 540],
                startTime=start_frame,
                endTime=end_frame,
                forceOverwrite=True
            )
            
            self.set_active_tab(3)
            self.page_preview.load_from_path(temp_dir)
            
        except Exception as e:
            cmds.warning(f"Erreur Playblast : {e}")
        finally:
            if model_panel:
                cmds.modelEditor(model_panel, e=True, allObjects=True)
                cmds.modelEditor(model_panel, e=True, grid=True)
                cmds.modelEditor(model_panel, e=True, headsUpDisplay=True)

    def run_animation_logic(self):
        try:
            # Positionnement à la frame 0 pour éviter les bugs
            cmds.currentTime(0)
            
            # Récupération Valeurs
            nb_pages = self.spin_pages.value()
            nb_pages_tournees = self.spin_pages_tournees.value() - 1 
            temps_total = self.spin_temps_total.value()
            frame_debut = self.spin_frame_debut.value()
            nb_part = self.spin_nb_particules.value()
            duree_emiss = self.spin_duree_emission.value()
            force_vortex = self.spin_force_vortex.value()
            couleur = self.couleur_particules
            
            # Parametres fixes ou calculés
            frame_ferme = 20
            frame_ouvre = 37
            if not (frame_ouvre - frame_ferme > 4): frame_ouvre = frame_ferme + 5
            
            # Calculs temps
            t_mouv = temps_total - frame_debut
            nb_lentes = max(1, nb_pages_tournees // 10)
            nb_norm = nb_pages_tournees - nb_lentes
            t_lentes = int(t_mouv * 0.20)
            dur_norm = (t_mouv - t_lentes) // nb_norm if nb_norm > 0 else 4
            dur_lente = t_lentes // nb_lentes if nb_lentes > 0 else 4

            # EXECUTION
            all_pages, all_bends = creer_pages(nb_pages, nb_pages_tournees, self.textures_list)
            rigger_pages()
            
            frame_fin = animer_pages(
                all_bends, nb_pages, nb_pages_tournees, frame_debut, 
                dur_norm, dur_lente, 4, frame_ferme, frame_ouvre
            )

            creer_particules_magiques(frame_fin, duree_emiss, nb_part, force_vortex, couleur)
            grimoire_flottant(frame_fin, duree_emiss)
            derniere_frame = gestion_lights_et_camera(frame_debut, duree_emiss, frame_fin, self.butterfly_project_name)
            
            cmds.playbackOptions(minTime=0, maxTime=derniere_frame + 48)
            
            # Supprimer le message d'erreur d'évaluation
            if cmds.objExists("rigidSolver"):
                try: cmds.delete("rigidSolver")
                except: pass
            
            cmds.inViewMessage(amg='<hl>Magie Terminée !</hl>', pos='midCenter', fade=True)
            
        except Exception as e:
            cmds.warning(f"Erreur : {e}")

def show_ui():
    global magic_win
    try:
        if magic_win:
            magic_win.close()
            magic_win.deleteLater()
    except: pass
    magic_win = MagicGrimoireUI()
    magic_win.show()

show_ui()