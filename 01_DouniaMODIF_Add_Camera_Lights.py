import maya.cmds as cmds
import mtoa.utils as mutils
import random
import math

def creer_pages(nombre_pages):
    #Crée les pages du grimoire
    
    # Nettoyage : supprimer les anciennes pages et matériaux s'ils existent déjà
    if cmds.objExists("Pages_GRP"):
        cmds.delete("Pages_GRP")
    if cmds.objExists("pagesSG"):
        cmds.delete("pagesSG")
    if cmds.objExists("shader_pages"):
        cmds.delete("shader_pages")

    # Nettoie l'ancien rig s'il existe
    if cmds.objExists("Pages_RIG_GRP"):
        cmds.delete("Pages_RIG_GRP")

    # Créer un groupe vide qui contiendra toutes les pages
    pages_grp = cmds.group(empty=True, name="Pages_GRP")
    all_pages = []
    
    # Position fixe du bord de la reliure pour TOUTES les pages
    reliure_z = 3.3  # Position fixe en Z du bord de la reliure
    
    # PARAMÈTRES DU DEMI-CERCLE
    # Rayon du demi-cercle formé par les pages
    rayon = (nombre_pages * 0.015) / math.pi  # Le rayon est calculé pour que l'arc corresponde à l'épaisseur totale
    y_base = 0.42  # Position Y de base (bas du demi-cercle)
    
    # Boucle pour créer chaque page
    for i in range(nombre_pages):
        # Variation aléatoire de la taille
        width = 9.4 - random.uniform(0, 0.1)  # Largeur entre 9.3 et 9.4
        depth = 6.6 - random.uniform(0, 0.1)  # Profondeur entre 6.5 et 6.6
        
        # Créer un cube plat pour représenter une page
        # [0] récupère le transform node
        page = cmds.polyCube(name=f"Page_{i+1:03d}", w=width, h=0.02, d=depth, sx=12, sy=12, sz=12)[0]
        
        # POSITION EN DEMI-CERCLE
        # Angle pour cette page (de π à 0 pour un demi-cercle, inversé pour partir du haut)
        angle = math.pi - (i / (nombre_pages - 1)) * math.pi
        
        # Position Y : base + espacement de base pour chaque page + composante verticale du cercle
        y_pos = y_base + i * 0.015 + rayon * math.sin(angle)
        
        # Petite variation aléatoire en X
        x_offset = random.uniform(-0.05, 0.05)
        
        # CALCUL DE LA POSITION EN Z pour le demi-cercle avec ondulation
        # Base Z (position du bord de reliure aligné)
        z_base = reliure_z - depth/2
        # Progression normalisée (0 à 1)
        t = i / (nombre_pages - 1)
        # Ondulation : bas rentré, milieu sorti davantage, haut rentré
        ondulation = math.sin(t * math.pi) * 0.15
        # Ajouter la composante horizontale du cercle + ondulation
        z_pos = z_base + rayon * (1 - math.cos(angle)) + ondulation
        
        # Déplacer la page à sa position finale
        cmds.move(x_offset, y_pos, z_pos, page)
        
        # Parenter la page au groupe
        cmds.parent(page, pages_grp)
        
        # Ajouter la page à la liste
        all_pages.append(page)
        
    # Création d'un groupe vide qui contiendra les bends des pages
    bend_grp = cmds.group(empty=True, name="Bend_GRP")
    
    i = 1    
    for une_page in all_pages:
        
        # On ajoute des Bend Deformer pour les pages:
                          
        # On récupère les coordonnées du bord de chaque page 
        bbox = cmds.exactWorldBoundingBox(une_page)
        pivot_x = (bbox[0] + bbox[3]) / 2
        pivot_y = -3
        pivot_z = bbox[5]
            
        # On sélectionne la page sur laquelle ajouter un bend
        cmds.select(f"{une_page}")
        bend_result = cmds.nonLinear(n="bend_"+str(i), type='bend')
        bend_handle = bend_result[1]  # On récupère seulement le handle
        
        # Parenter le bend au groupe
        cmds.parent(bend_handle, bend_grp)
            
        # Déplacer et rotater le bend sur le bord de la page
        cmds.move(pivot_x, pivot_y, pivot_z, bend_handle)
        cmds.rotate(90, -90, -90, bend_handle)
        i = i + 1

    # CRÉATION DU MATÉRIAU BLANC POUR LES PAGES
    
    # Créer un shader Lambert pour les pages
    shader_page = cmds.shadingNode('lambert', asShader=True, name='shader_pages')
    
    # Définir la couleur blanc pour un aspect papier
    cmds.setAttr(shader_page + ".color", 0.95, 0.95, 0.95, type="double3")
    
    # Créer un shading group
    sg_page = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name='pagesSG')
    
    # Connecter le shader au shading group
    cmds.connectAttr(shader_page + ".outColor", sg_page + ".surfaceShader", f=True)
    
    # Assigner le matériau à toutes les pages
    cmds.sets(all_pages, e=True, forceElement=sg_page)
    
    return all_pages

def rigger_pages():
    """
    Crée un système de rig pour chaque page avec des contrôleurs
    
    LOGIQUE: 
    - Chaque page a besoin d'un pivot sur le bord de la reliure pour tourner correctement
    - Au lieu de modifier directement le pivot de la page (chiant), j'ai crée un locator
    - Le locator est placé au bord de la reliure
    - La page est parentée au locator
    - Quand on anime le locator, la page tourne autour du bon pivot
    """
    
    # Vérifie que les pages existent
    if not cmds.objExists("Pages_GRP"):
        return
    
    # Nettoie l'ancien rig s'il existe
    if cmds.objExists("Pages_RIG_GRP"):
        cmds.delete("Pages_RIG_GRP")
    
    # Récupére toutes les pages créées
    all_pages = cmds.listRelatives("Pages_GRP", children=True, type='transform')
    if not all_pages:
        return
    
    # Créer un groupe pour organiser tous les contrôleurs
    rig_grp = cmds.group(empty=True, name="Pages_RIG_GRP")
    all_controls = []
    
    # Créer un contrôleur pour chaque page
    for page in all_pages:
        # CALCUL DE LA POSITION DU PIVOT
        
        # Récupérer la bounding box (boîte englobante) de la page
        bbox = cmds.exactWorldBoundingBox(page)
        
        # Position du pivot :
        pivot_x = (bbox[0] + bbox[3]) / 2
        pivot_y = cmds.getAttr(f"{page}.translateY")
        pivot_z = bbox[5]
        
        # CRÉATION DU CONTRÔLEUR
        ctrl_name = f"{page}_CTRL"
        ctrl = cmds.spaceLocator(name=ctrl_name)[0]
        
        # Positionner le contrôleur exactement au pivot calculé
        cmds.move(pivot_x, pivot_y, pivot_z, ctrl)
        
        # PARENTAGE DE LA PAGE AU CONTRÔLEUR
        
        # Sauvegarde la position/rotation actuelle de la page dans l'espace monde
        page_pos = cmds.xform(page, query=True, worldSpace=True, translation=True)
        page_rot = cmds.xform(page, query=True, worldSpace=True, rotation=True)
        
        # Parenter la page au contrôleur
        cmds.parent(page, ctrl)
        
        # Restaurer la position/rotation dans l'espace monde
        cmds.xform(page, worldSpace=True, translation=page_pos)
        cmds.xform(page, worldSpace=True, rotation=page_rot)
        
        # Freeze transforms
        cmds.makeIdentity(page, apply=True, translate=True, rotate=True, scale=True)
        
        # Organiser le contrôleur dans le groupe de rig
        cmds.parent(ctrl, rig_grp)
        all_controls.append(ctrl)
    
    # Si `Pages_GRP` existe mais est vide, le supprimer
    if cmds.objExists("Pages_GRP"):
        descendants = cmds.listRelatives("Pages_GRP", allDescendents=True) or []
        if len(descendants) == 0:
            try:
                cmds.delete("Pages_GRP")
            except Exception:
                pass

    return all_controls

def animer_pages(nombre_pages_a_tourner=10, frame_debut=1, duree_par_page=8, acceleration=True):
    """
    Anime les pages qui tournent via leur rig
    
    LOGIQUE DE L'ANIMATION :
    Chaque page fait une rotation de 180° autour de l'axe X (se retourne)
    Chaque page descend en Y pour s'empiler au bon endroit
    L'accélération fait que les premières pages tournent lentement, puis de plus en plus vite
    """
    
    # Vérifier que le rig existe
    if not cmds.objExists("Pages_RIG_GRP"):
        return
    
    # Récupérer tous les contrôleurs
    all_controls = cmds.listRelatives("Pages_RIG_GRP", children=True, type='transform')
    if not all_controls:
        return
    
    # Trier les contrôleurs par nom pour avoir un ordre cohérent
    all_controls.sort()
    
    # SÉLECTION DES PAGES À ANIMER
    controls_a_animer = all_controls[(-nombre_pages_a_tourner-1):]
    controls_a_animer.reverse()
    
    all_bends = cmds.listRelatives("Bend_GRP", children=True, type='transform')
    if not all_bends:
        return

    bends_a_animer = all_bends[(-nombre_pages_a_tourner-1):]
    bends_a_animer.reverse()

    # PARAMÈTRES D'EMPILEMENT
    y_base = 0.42
    epaisseur = 0.015
    
    # Frame actuelle dans la timeline (on commence à frame_debut)
    frame_actuelle = frame_debut
    
    # BOUCLE D'ANIMATION DE CHAQUE PAGE

    M = len(controls_a_animer)
    power = 10.6

    # Sécurité
    if M <= temps_minimum_animation_page:
        durations = [max(temps_minimum_animation_page, int(duree_lente))] * M
    else:
        durations = []
        for i in range(M):
            t = (i / (M - 1)) ** power
            dur = duree_normale + (duree_lente - duree_normale) * t
            durations.append(max(1, int(round(dur))))
    print("Durations list:", durations)

    for i, ctrl in enumerate(controls_a_animer):
        duree = durations[i] 
        
        # CALCUL DES POSITIONS DE FIN (formules en arc)
        
        # Positions actuelles
        y_start = cmds.getAttr(f"{ctrl}.translateY")
        z_start = cmds.getAttr(f"{ctrl}.translateZ")
        
        # N = nombre de pages qui tournent
        N = len(all_controls)
        
        # n = position de cette page dans la liste des pages qui tournent (0 à N-1)
        n = i
        
        # Formules pour les positions finales en arc
        y_end = y_base + (N * epaisseur / math.pi) * math.sin(n * math.pi / (N - 1))
        z_end = z_start + (N * epaisseur / math.pi) * (math.cos(n * math.pi / (N - 1)) + 1)
    
        # ANIMATION DE ROTATION (axe X)
        cmds.setKeyframe(ctrl, attribute='rotateX', value=0, time=frame_actuelle)
        
        frame_fin = frame_actuelle + duree
        
        cmds.setKeyframe(ctrl, attribute='rotateX', value=180, time=frame_fin)
        
        cmds.keyTangent(ctrl, attribute='rotateX', time=(frame_actuelle, frame_fin), 
                       inTangentType='spline', outTangentType='spline')
        
        # ANIMATION DE TRANSLATION Y et Z (hauteur et profondeur)
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_start, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_end, time=frame_fin)
        
        cmds.setKeyframe(ctrl, attribute='translateZ', value=z_start, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='translateZ', value=z_end, time=frame_fin)
        
        cmds.keyTangent(ctrl, attribute='translateY', time=(frame_actuelle, frame_fin),
                       inTangentType='spline', outTangentType='spline')
        cmds.keyTangent(ctrl, attribute='translateZ', time=(frame_actuelle, frame_fin),
                       inTangentType='spline', outTangentType='spline')
        
        # VARIATION ALÉATOIRE EN Z
        variation_z = random.uniform(-1, 1)
        
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=variation_z, time=frame_actuelle + duree//2)
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_fin)
        
        # CHEVAUCHEMENT (OVERLAP)
        frame_actuelle += duree - 2

    frame_actuelle = frame_debut

    M = len(bends_a_animer)
    power = 10.6

    # Sécurité
    if M <= temps_minimum_animation_page:
        durations = [max(temps_minimum_animation_page, int(duree_lente))] * M
    else:
        durations = []
        for i in range(M):
            t = (i / (M - 1)) ** power
            dur = duree_normale + (duree_lente - duree_normale) * t
            durations.append(max(1, int(round(dur))))
    print("Durations list:", durations)

    for j, bend in enumerate(bends_a_animer): 
        duree = durations[j]
        
        bend_node = cmds.listConnections(bend, type='nonLinear')[0]
        cmds.setKeyframe(bend_node, attribute="curvature", value=0, time=frame_actuelle)
        
        frame_fin = frame_actuelle + duree
        frame_mid = (frame_actuelle + frame_fin) / 2
        
        cmds.setKeyframe(bend_node, attribute='curvature', value=100, time=frame_mid)
        cmds.setKeyframe(bend_node, attribute='curvature', value=0, time=frame_fin)

        frame_actuelle += duree - 2
    
    # Ajouter une pause de 20 frames à la fin
    frame_finale = frame_actuelle + 10
    
    # Mettre à jour la timeline de Maya pour afficher toute l'animation (avec marge pour les particules)
    #cmds.playbackOptions(minTime=frame_debut, maxTime=frame_finale + 80)
    

    #---------------------------------------------------------------------
    """JB PASSE PAR LA POUR METTRE LE 
    minTime à 0
    et avoir un peu plus de marge 
    pour finir l'animation
    """
    cmds.playbackOptions(minTime=0, maxTime=frame_finale + 250)
    #---------------------------------------------------------------------



    # Retourner la frame finale pour savoir quand démarrer les particules
    return frame_finale

def creer_particules_magiques(frame_debut_particules, duree_emission=60):
    """
    Crée un système de particules magiques qui s'échappent du centre du livre vers le haut
    """
    
    # Nettoyer les anciens systèmes
    objets_a_supprimer = ["particules_magiques", "emetteur_particules", "gravity_up", "turbulence_magique", 
                          "shader_particules_magiques", "particulesSG", "sphere_instance_1", "sphere_instance_2", 
                          "sphere_instance_3", "instancer_particules"]
    
    for obj in objets_a_supprimer:
        if cmds.objExists(obj): 
            cmds.delete(obj)
    
    # POSITION DE L'ÉMETTEUR
    emetteur_x = 0
    emetteur_y = 1.2
    emetteur_z = 3.3
    
    # CRÉER LE SYSTÈME DE PARTICULES
    particules = cmds.particle(name="particules_magiques")[0]
    particule_shape = cmds.listRelatives(particules, shapes=True)[0]
    
    # CRÉER L'ÉMETTEUR
    emetteur = cmds.emitter(
        pos=[emetteur_x, emetteur_y, emetteur_z], 
        name="emetteur_particules", 
        type='omni',
        rate=200,
        speed=3.0,
        speedRandom=1.5,
        directionX=0,
        directionY=1,
        directionZ=0,
        spread=0.3
    )[0]
    
    # Connecter l'émetteur aux particules
    cmds.connectDynamic(particule_shape, em=emetteur)
    
    # CRÉER LES CHAMPS DE FORCE
    gravity_field = cmds.gravity(
        pos=[emetteur_x, emetteur_y, emetteur_z], 
        name="gravity_up",
        magnitude=9.8,
        attenuation=0,
        directionX=0,
        directionY=1,
        directionZ=0
    )[0]
    
    cmds.connectDynamic(particule_shape, fields=gravity_field)
    
    turbulence_field = cmds.turbulence(
        pos=[emetteur_x, emetteur_y, emetteur_z], 
        name="turbulence_magique", 
        magnitude=1.0,
        attenuation=0.2, 
        frequency=1.5
    )[0]
    
    cmds.connectDynamic(particule_shape, fields=turbulence_field)
    
    # SHADER pour les sphères (doré brillant)
    shader_particules = cmds.shadingNode('lambert', asShader=True, name='shader_particules_magiques')
    cmds.setAttr(shader_particules + ".color", 1.0, 0.84, 0.0, type="double3")
    cmds.setAttr(shader_particules + ".incandescence", 1.0, 0.9, 0.3, type="double3")
    cmds.setAttr(shader_particules + ".glowIntensity", 0.5)
    
    sg_particules = cmds.sets(renderable=True, noSurfaceShader=True, empty=True, name='particulesSG')
    cmds.connectAttr(shader_particules + ".outColor", sg_particules + ".surfaceShader", f=True)
    
    # CRÉER PLUSIEURS SPHÈRES DE TAILLES DIFFÉRENTES 
    sphere1 = cmds.polySphere(name="sphere_instance_1", radius=0.04, subdivisionsAxis=6, subdivisionsHeight=6)[0]
    sphere2 = cmds.polySphere(name="sphere_instance_2", radius=0.05, subdivisionsAxis=6, subdivisionsHeight=6)[0]
    sphere3 = cmds.polySphere(name="sphere_instance_3", radius=0.06, subdivisionsAxis=6, subdivisionsHeight=6)[0]
    
    # Assigner le shader aux sphères
    cmds.sets([sphere1, sphere2, sphere3], e=True, forceElement=sg_particules)
    
    # AJOUTER L'ATTRIBUT objectIndex pour choisir quelle sphère utiliser
    cmds.addAttr(particule_shape, longName='objectIndex', dataType='doubleArray')
    cmds.addAttr(particule_shape, longName='objectIndex0', dataType='doubleArray')
    
    # Expression pour assigner aléatoirement une des 3 sphères à chaque particule
    expression_index = """
objectIndex = floor(rand(0, 2.99));
"""
    cmds.dynExpression(particule_shape, string=expression_index, creation=True)
    
    # CRÉER L'INSTANCIER avec les 3 sphères
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
    
    # Cacher les sphères originales
    cmds.hide(sphere1, sphere2, sphere3)
    
    # CONFIGURER LES PARTICULES
    
    # Couleurs dorées scintillantes
    cmds.addAttr(particule_shape, longName='rgbPP', dataType='vectorArray')
    cmds.addAttr(particule_shape, longName='rgbPP0', dataType='vectorArray')
    
    expression_color = """
float $variation = rand(0.7, 1.0);
vector $color = <<1.0 * $variation, 0.84 * $variation, 0.0>>;
rgbPP = $color;
"""
    cmds.dynExpression(particule_shape, string=expression_color, creation=True)
    
    # Opacité qui diminue avec le temps
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
    
    # ANIMER L'ÉMISSION
    frame_fin_emission = frame_debut_particules + duree_emission
    
    cmds.setKeyframe(emetteur, attribute='rate', value=0, time=frame_debut_particules - 1)
    cmds.setKeyframe(emetteur, attribute='rate', value=200, time=frame_debut_particules)
    cmds.setKeyframe(emetteur, attribute='rate', value=200, time=frame_fin_emission - 10)
    cmds.setKeyframe(emetteur, attribute='rate', value=0, time=frame_fin_emission)
    
    print(f"Particules magiques créées ! Elles commencent à la frame {frame_debut_particules}")
    print(f"Tailles paillettes : 0.02, 0.03, 0.04")
    
    return particules

def animer_pages_qui_ne_se_tournent_pas(nombre_pages_a_tourner, frame_debut, duree_totale):
    """
    Anime les pages qui ne se tournent pas pour qu'elles se positionnent aussi sur l'arc
    SANS rotation - juste translation Y et Z
    """
    
    # Vérifier que le rig existe
    if not cmds.objExists("Pages_RIG_GRP"):
        return
    
    # Récupérer tous les contrôleurs
    all_controls = cmds.listRelatives("Pages_RIG_GRP", children=True, type='transform')
    if not all_controls:
        return
    
    # Trier les contrôleurs par nom
    all_controls.sort()
    
    # Sélectionner les pages qui ne sont PAS animées par animer_pages
    controls_non_tournes = all_controls[:-(nombre_pages_a_tourner+1)]
    
    # PARAMÈTRES
    y_base = 0.42
    epaisseur = 0.015
    N = nombre_pages
    
    # Frame de début et de fin
    frame_fin = frame_debut + duree_totale
    
    # Animer chaque page non tournée
    for ctrl in controls_non_tournes:
        # Positions actuelles
        y_start = cmds.getAttr(f"{ctrl}.translateY")
        z_start = cmds.getAttr(f"{ctrl}.translateZ")
        
        # Numéro de la page
        n = N - int(ctrl.split('_')[-2])
        
        # Formules pour les positions finales en arc
        y_end = y_base + (N * epaisseur / math.pi) * math.sin(n * math.pi / (N - 1))
        z_end = z_start + (N * epaisseur / math.pi) * (math.cos(n * math.pi / (N - 1)) + 1)
        
        # ANIMATION DE TRANSLATION Y et Z uniquement (PAS de rotation)
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_start, time=frame_debut)
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_end, time=frame_fin)
        
        cmds.setKeyframe(ctrl, attribute='translateZ', value=z_start, time=frame_debut)
        cmds.setKeyframe(ctrl, attribute='translateZ', value=z_end, time=frame_fin)
        
        # Courbes fluides
        cmds.keyTangent(ctrl, attribute='translateY', time=(frame_debut, frame_fin), inTangentType='spline', outTangentType='spline')
        cmds.keyTangent(ctrl, attribute='translateZ', time=(frame_debut, frame_fin), inTangentType='spline', outTangentType='spline')

def gestion_lights_et_camera(Temps_total, frame_debut, duree_emission, frame_fin_animation):
    # Delete les groupes existants déjà (contenant la caméra, et les lights)
    if cmds.objExists("Lights_GRP"):
        cmds.delete("Lights_GRP")
    if cmds.objExists("Camera_GRP"):
        cmds.delete("Camera_GRP")
    
    # Création des groupes pour les lights et la caméra
    lights_grp = cmds.group(empty=True, name="Lights_GRP")
    camera_grp = cmds.group(empty=True, name="Camera_GRP")

    # Création de la KeyLight et de ses propriétés : une AreaLight
    mutils.createLocator('aiAreaLight', asLight=True)
    keyArea = cmds.rename('aiAreaLight1', "areaKey_lgt")
    cmds.select("areaKey_lgt")
    cmds.move(7.431, 5.445, 2.523)
    cmds.rotate(-16.148, 90, 0)
    cmds.scale(15.301, 4.567, 1)
    cmds.setAttr("areaKey_lgtShape.color", 0.814,0.601,0.415)
    cmds.setAttr("areaKey_lgtShape.exposure", 11)
    cmds.parent(keyArea, lights_grp)
    
    # Création de la FillLight et de ses propriétés : une SpotLight
    spotFill = cmds.spotLight(n='spotFill_lgt', coneAngle = 32, penumbra = 10, rgb=[0.814,0.601,0.415], intensity=10000)
    cmds.select("spotFill_lgt")
    cmds.move(0.272, 20, 3.986)
    cmds.rotate(-90, 0, 0)
    #cmds.setAttr('spotFill_lgtShape.exposure', 11) #ca marche pas ca, donc j'ai mis de l'intensité à la place
    #cmds.setAttr('spotFill_lgtShape.radius', 10)
    #cmds.setAttr('spotFill_lgtShape.roundness', 0.883)
    spotFill = cmds.listRelatives('spotFill_lgtShape', parent=True)[0]
    cmds.parent(spotFill, lights_grp)

    # Création du SkyDome et de ses propriétés : 
    mutils.createLocator('aiSkyDomeLight', asLight=True)
    backSky = cmds.rename('aiSkyDomeLight1', "backSkyDome_lgt")
    cmds.select("backSkyDome_lgt")
    cmds.move(0, 1000, 0)
    cmds.scale(0.1, 0.1, 0.1)
    cmds.setAttr("backSkyDome_lgtShape.color", 0.011,0.003,0.022)
    cmds.setAttr("backSkyDome_lgtShape.intensity", 1.850)
    cmds.parent(backSky, lights_grp)

    # Création de la caméra :
    cmds.camera(n = "renderCamera")
    cmds.move(26.116, 15.007, 20.201)
    cmds.rotate(-25.279, 55.821, 0)
    cmds.scale(3.5, 3.5, 3.5)
    renderCam = cmds.rename('renderCamera1', "renderCamera")
    cmds.parent(renderCam, camera_grp)
    

    # Début de :sparkles: l'animation :sparkles: (ca fait des superbes étoiles sur discord les :sparkles:)
    cmds.setKeyframe(renderCam, time=0)

    # Travelling avant jusqu'a ce que le grimoire s'ouvre
    cmds.setKeyframe(renderCam, attribute='translateX', value=22.986, time = frame_debut)
    cmds.setKeyframe(renderCam, attribute='translateY', value=13.22, time = frame_debut)
    cmds.setKeyframe(renderCam, attribute='translateZ', value=18.076, time = frame_debut)

    # Une fois grimoire en cours d'ouverture, on s'aligne avec lui et on monte un peu jusqu'aux particules
    cmds.setKeyframe(renderCam, attribute='translateX', value=21, time = frame_fin_animation)
    cmds.setKeyframe(renderCam, attribute='translateY', value=18, time = frame_fin_animation)
    cmds.setKeyframe(renderCam, attribute='translateZ', value=4.338, time = frame_fin_animation)
    cmds.setKeyframe(renderCam, attribute='rotateX', value=-41, time = frame_fin_animation)
    cmds.setKeyframe(renderCam, attribute='rotateY', value=90, time = frame_fin_animation)
    cmds.setKeyframe(renderCam, attribute='rotateZ', value=0, time = frame_fin_animation)

    # Début des particules : on bouge pas au début
    finAnim_plus_emission_0_5 = frame_fin_animation + duree_emission / 2
    cmds.setKeyframe(renderCam, attribute='translateX', value=21, time = finAnim_plus_emission_0_5)
    cmds.setKeyframe(renderCam, attribute='translateY', value=18, time = finAnim_plus_emission_0_5)
    cmds.setKeyframe(renderCam, attribute='translateZ', value=4.338, time = finAnim_plus_emission_0_5)
    cmds.setKeyframe(renderCam, attribute='rotateX', value=-41, time = finAnim_plus_emission_0_5)
    cmds.setKeyframe(renderCam, attribute='rotateY', value=90, time = finAnim_plus_emission_0_5)
    cmds.setKeyframe(renderCam, attribute='rotateZ', value=0, time = finAnim_plus_emission_0_5)

    # On arrive sur un plan zénithal et travelling avant lors de la 2e moitié de l'émission des particules
    finAnim_plus_emission_1_75 = frame_fin_animation + duree_emission * 1.75
    cmds.setKeyframe(renderCam, attribute='translateX', value=1.84, time = finAnim_plus_emission_1_75)
    cmds.setKeyframe(renderCam, attribute='translateY', value=23.412, time = finAnim_plus_emission_1_75)
    cmds.setKeyframe(renderCam, attribute='translateZ', value=4.427, time = finAnim_plus_emission_1_75)
    cmds.setKeyframe(renderCam, attribute='rotateX', value=-86, time = finAnim_plus_emission_1_75)
    cmds.setKeyframe(renderCam, attribute='rotateY', value=90, time = finAnim_plus_emission_1_75)
    cmds.setKeyframe(renderCam, attribute='rotateZ', value=0, time = finAnim_plus_emission_1_75)

    # On bouge pas pendant qq frames
    finAnim_plus_emission_1_92 = frame_fin_animation + duree_emission * 1.92
    cmds.setKeyframe(renderCam, attribute='translateX', value=1.84, time = finAnim_plus_emission_1_92)
    cmds.setKeyframe(renderCam, attribute='translateY', value=23.412, time = finAnim_plus_emission_1_92)
    cmds.setKeyframe(renderCam, attribute='translateZ', value=4.427, time = finAnim_plus_emission_1_92)
    cmds.setKeyframe(renderCam, attribute='rotateX', value=-86, time = finAnim_plus_emission_1_92)
    cmds.setKeyframe(renderCam, attribute='rotateY', value=90, time = finAnim_plus_emission_1_92)
    cmds.setKeyframe(renderCam, attribute='rotateZ', value=0, time = finAnim_plus_emission_1_92)

    # Travelling sur la page avec le PNG du Lighting de Matea
    finAnim_plus_emission_2_5 = frame_fin_animation + duree_emission * 2.85
    cmds.setKeyframe(renderCam, attribute='translateX', value=0.153, time = finAnim_plus_emission_2_5)
    cmds.setKeyframe(renderCam, attribute='translateY', value=7.147, time = finAnim_plus_emission_2_5)
    cmds.setKeyframe(renderCam, attribute='translateZ', value=0.444, time = finAnim_plus_emission_2_5)
    cmds.setKeyframe(renderCam, attribute='rotateX', value=-90, time = finAnim_plus_emission_2_5)
    cmds.setKeyframe(renderCam, attribute='rotateY', value=90, time = finAnim_plus_emission_2_5)
    cmds.setKeyframe(renderCam, attribute='rotateZ', value=0, time = finAnim_plus_emission_2_5)

# paramètres

# Temps total de l'animation (modifiable)
Temps_total = 300

# Nombre de pages (modifiable)
nombre_pages = 50

# Nombre de pages à tourner (modifiable) mais laisser le -1
nombre_pages_a_tourner = 25 - 1

# Temps avant ouverture grimoire (modifiable)
frame_debut = 35

# Pas moins de 4 sinon les pages n'ont pas assez de temps pour tourner (pas touche !)
temps_minimum_animation_page = 4

# Calcul du nombre d'images pour tourner une page
duree_par_page = (Temps_total - frame_debut) // nombre_pages_a_tourner

# Sécurité : pour que chaque page ait le temps minimum pour tourner
if duree_par_page < temps_minimum_animation_page:
    print("trop de pages à tourner pour le temps imparti")
    duree_par_page = temps_minimum_animation_page
    nombre_pages_a_tourner = (Temps_total - frame_debut) // temps_minimum_animation_page
    
# Temps total des pages sans le temps avant l'ouverture du grimoire
temps_total_mouvement = Temps_total - frame_debut

# Dernier 1/10 des pages = ralenties
nb_pages_lentes = max(1, nombre_pages_a_tourner // 10)
nb_pages_normales = nombre_pages_a_tourner - nb_pages_lentes

# Répartition du temps (20% pour pages lentes)
temps_pages_lentes = int(temps_total_mouvement * 0.20)
temps_pages_normales = temps_total_mouvement - temps_pages_lentes

# Durée par page
duree_normale = temps_pages_normales // nb_pages_normales
duree_lente = temps_pages_lentes // nb_pages_lentes

# Variable globale pour le positionnement des locators en arc
coordonnee_z = 3.3

# éxécution 
creer_pages(nombre_pages)
rigger_pages()
frame_fin_animation = animer_pages(nombre_pages_a_tourner, frame_debut, duree_normale, acceleration=False)

# Les pages qui ne tournent pas restent en demi-cercle (pas d'animation)
# animer_pages_qui_ne_se_tournent_pas(nombre_pages_a_tourner, frame_debut, Temps_total - frame_debut)

duree_emission = 60

# CRÉER LES PARTICULES MAGIQUES
creer_particules_magiques(frame_fin_animation, duree_emission)

# CRÉER ET ANIMER LES CAMERAS ET LIGHTS
gestion_lights_et_camera(Temps_total, frame_debut, duree_emission, frame_fin_animation)