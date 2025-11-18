import maya.cmds as cmds
import random

def creer_pages(nombre_pages):
    #Crée les pages du grimoire
    
    if cmds.objExists("Pages_GRP"):
        cmds.delete("Pages_GRP")
    if cmds.objExists("pagesSG"):
        cmds.delete("pagesSG")
    if cmds.objExists("shader_pages"):
        cmds.delete("shader_pages")
    
    pages_grp = cmds.group(empty=True, name="Pages_GRP")
    all_pages = []
    
    for i in range(nombre_pages):
        width = 9.4 - random.uniform(0, 0.1)
        depth = 6.6 - random.uniform(0, 0.1)
        page = cmds.polyCube(name=f"Page_{i+1:02d}", w=width, h=0.02, d=depth)[0]
        
        y_pos = 0.42 + i * 0.015
        x_offset = random.uniform(-0.05, 0.05)
        cmds.move(x_offset, y_pos, 0, page)
        cmds.rotate(0, random.uniform(-2, 2), 0, page)
        cmds.parent(page, pages_grp)
        all_pages.append(page)
    
    shader_page = cmds.shadingNode('lambert', asShader=True, name='shader_pages')
    cmds.setAttr(shader_page + ".color", 0.95, 0.95, 0.95, type="double3")
    sg_page = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name='pagesSG')
    cmds.connectAttr(shader_page + ".outColor", sg_page + ".surfaceShader", f=True)
    cmds.sets(all_pages, e=True, forceElement=sg_page)
    
    return all_pages


def rigger_pages():
    #Crée un rig pour chaque page avec des contrôleurs
    
    if not cmds.objExists("Pages_GRP"):
        return
    
    if cmds.objExists("Pages_RIG_GRP"):
        cmds.delete("Pages_RIG_GRP")
    
    all_pages = cmds.listRelatives("Pages_GRP", children=True, type='transform')
    if not all_pages:
        return
    
    rig_grp = cmds.group(empty=True, name="Pages_RIG_GRP")
    all_controls = []
    
    for page in all_pages:
        bbox = cmds.exactWorldBoundingBox(page)
        
        # Pivot sur le bord de la reliure (bord en Z)
        pivot_x = (bbox[0] + bbox[3]) / 2  # Centre en X
        pivot_y = cmds.getAttr(f"{page}.translateY")
        pivot_z = bbox[2]  # Bord de la reliure
        
        ctrl_name = f"{page}_CTRL"
        ctrl = cmds.spaceLocator(name=ctrl_name)[0]
        
        cmds.move(pivot_x, pivot_y, pivot_z, ctrl)
        
        page_pos = cmds.xform(page, query=True, worldSpace=True, translation=True)
        page_rot = cmds.xform(page, query=True, worldSpace=True, rotation=True)
        
        cmds.parent(page, ctrl)
        
        cmds.xform(page, worldSpace=True, translation=page_pos)
        cmds.xform(page, worldSpace=True, rotation=page_rot)
        
        cmds.makeIdentity(page, apply=True, translate=True, rotate=True, scale=True)
        
        cmds.parent(ctrl, rig_grp)
        all_controls.append(ctrl)
    
    return all_controls


def animer_pages(nombre_pages_a_tourner=10, frame_debut=1, duree_par_page=8, acceleration=True):
    #Anime les pages qui tournent via leur rig
    
    if not cmds.objExists("Pages_RIG_GRP"):
        return
    
    all_controls = cmds.listRelatives("Pages_RIG_GRP", children=True, type='transform')
    if not all_controls:
        return
    
    all_controls.reverse()
    controls_a_animer = all_controls[:nombre_pages_a_tourner]
    
    frame_actuelle = frame_debut
    
    for i, ctrl in enumerate(controls_a_animer):
        if acceleration:
            facteur = 1.0 - (i / len(controls_a_animer)) * 0.7
            duree = int(duree_par_page * facteur)
        else:
            duree = duree_par_page
        
        # Rotation autour de X pour que la page tourne
        cmds.setKeyframe(ctrl, attribute='rotateX', value=0, time=frame_actuelle)
        frame_fin = frame_actuelle + duree
        cmds.setKeyframe(ctrl, attribute='rotateX', value=-180, time=frame_fin)  # -180 ou 180 selon le sens
        
        cmds.keyTangent(ctrl, attribute='rotateX', time=(frame_actuelle, frame_fin), 
                       inTangentType='spline', outTangentType='spline')
        
        variation_z = random.uniform(-1, 1)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=variation_z, time=frame_actuelle + duree//2)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_fin)
        
        frame_actuelle += duree - 2
    
    frame_finale = frame_actuelle + 20
    cmds.playbackOptions(minTime=frame_debut, maxTime=frame_finale)


def ralentir_pages(frame_debut_ralentissement, duree_ralentissement=30):
    #Ralentit progressivement l'animation
    
    if not cmds.objExists("Pages_RIG_GRP"):
        return
    
    all_controls = cmds.listRelatives("Pages_RIG_GRP", children=True, type='transform')
    all_controls.reverse()
    
    controls_en_mouvement = []
    for ctrl in all_controls:
        keyframes = cmds.keyframe(ctrl, attribute='rotateX', query=True, time=(frame_debut_ralentissement, 10000))
        if keyframes:
            controls_en_mouvement.append(ctrl)
    
    if not controls_en_mouvement:
        return
    
    for ctrl in controls_en_mouvement:
        rotation_actuelle = cmds.getAttr(f"{ctrl}.rotateX", time=frame_debut_ralentissement)
        frame_fin = frame_debut_ralentissement + duree_ralentissement
        cmds.setKeyframe(ctrl, attribute='rotateX', value=rotation_actuelle, time=frame_fin)
        cmds.keyTangent(ctrl, attribute='rotateX', 
                       time=(frame_debut_ralentissement, frame_fin),
                       outTangentType='linear')


# Utilisation
creer_pages(nombre_pages=50)
rigger_pages()
animer_pages(nombre_pages_a_tourner=15, frame_debut=1, duree_par_page=8, acceleration=True)