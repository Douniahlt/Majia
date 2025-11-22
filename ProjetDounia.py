import maya.cmds as cmds
import random

def creer_pages(nombre_pages):
    #Crée les pages du grimoire
    
    # Nettoyage : supprimer les anciennes pages et matériaux s'ils existent déjà
    if cmds.objExists("Pages_GRP"):
        cmds.delete("Pages_GRP")
    if cmds.objExists("pagesSG"):
        cmds.delete("pagesSG")
    if cmds.objExists("shader_pages"):
        cmds.delete("shader_pages")
    
    # Créer un groupe vide qui contiendra toutes les pages
    pages_grp = cmds.group(empty=True, name="Pages_GRP")
    all_pages = []
    
    # Boucle pour créer chaque page
    for i in range(nombre_pages):
        # Variation aléatoire de la taille
        width = 9.4 - random.uniform(0, 0.1)  # Largeur entre 9.3 et 9.4
        depth = 6.6 - random.uniform(0, 0.1)  # Profondeur entre 6.5 et 6.6
        
        # Créer un cube plat pour représenter une page
        # [0] récupère le transform node
        page = cmds.polyCube(name=f"Page_{i+1:02d}", w=width, h=0.02, d=depth)[0]
        
        # Positionner chaque page en hauteur pour créer la pile
        # L'espacement de 0.015 crée l'épaisseur de la pile
        y_pos = 0.42 + i * 0.015
        
        # Petite variation aléatoire en X
        x_offset = random.uniform(-0.05, 0.05)
        
        # Déplacer la page à sa position finale
        cmds.move(x_offset, y_pos, 0, page)
        
        # Petite rotation aléatoire en Y pour que les pages ne soient pas parfaitement alignées
        cmds.rotate(0, random.uniform(-2, 2), 0, page)
        
        # Parenter la page au groupe
        cmds.parent(page, pages_grp)
        
        # Ajouter la page à la liste
        all_pages.append(page)
    
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
        # La bounding box est une boîte invisible qui entoure parfaitement l'objet
        # Elle nous donne les coordonnées min/max de l'objet dans l'espace 3D
        # bbox = [xmin, ymin, zmin, xmax, ymax, zmax]
        bbox = cmds.exactWorldBoundingBox(page)
        
        # Position du pivot :
        # - En X : centre de la page (pour que la rotation soit centrée)
        pivot_x = (bbox[0] + bbox[3]) / 2
        
        # - En Y : hauteur de la page
        pivot_y = cmds.getAttr(f"{page}.translateY")
        
        # - En Z : bbox[5] = bord avant de la page (l'autre côté de la reliure)
        #   C'est ici que les pages tournent
        pivot_z = bbox[5]
        
        # CRÉATION DU CONTRÔLEUR
        
        # Créer un locator (axe 3D) qui servira de contrôleur
        ctrl_name = f"{page}_CTRL"
        ctrl = cmds.spaceLocator(name=ctrl_name)[0]
        
        # Positionner le contrôleur exactement au pivot calculé
        cmds.move(pivot_x, pivot_y, pivot_z, ctrl)
        
        # PARENTAGE DE LA PAGE AU CONTRÔLEUR

        # PROBLÈME : Si on parente directement la page au contrôleur, sa position va sauter
        # car le référentiel local change (la page se positionne par rapport au contrôleur)
        
        # Sauvegarde la position/rotation actuelle de la page dans l'espace monde
        page_pos = cmds.xform(page, query=True, worldSpace=True, translation=True)
        page_rot = cmds.xform(page, query=True, worldSpace=True, rotation=True)
        
        # Parenter la page au contrôleur (ca va changer les coordonnées locales mais pas la position visuelle)
        # Maintenant, quand on bouge le contrôleur, la page suit
        cmds.parent(page, ctrl)
        
        # Restaurer la position/rotation dans l'espace monde
        # Pour que visuellement rien ne change
        cmds.xform(page, worldSpace=True, translation=page_pos)
        cmds.xform(page, worldSpace=True, rotation=page_rot)
        
        # Freeze transforms : réinitialiser les valeurs locales à 0
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
    # Page_01_CTRL, Page_02_CTRL, etc.
    all_controls.sort()
    
    # SÉLECTION DES PAGES À ANIMER
    
    # Prendre les dernières pages
    # Par exemple : si on a 50 pages et nombre_pages_a_tourner=15
    # On prend Page_36_CTRL à Page_50_CTRL 
    controls_a_animer = all_controls[-nombre_pages_a_tourner:]
    
    # Inverser l'ordre pour commencer par la page la plus haute
    # Maintenant : Page_50_CTRL, Page_49_CTRL, ..., Page_36_CTRL
    controls_a_animer.reverse()
    
    # PARAMÈTRES D'EMPILEMENT
    
    # Hauteur de base où les pages tournées vont s'empiler
    y_base = 0.42
    
    # Épaisseur entre chaque page empilée
    epaisseur = 0.015
    
    # Frame actuelle dans la timeline (on commence à frame_debut)
    frame_actuelle = frame_debut
    
    # BOUCLE D'ANIMATION DE CHAQUE PAGE
    
    for i, ctrl in enumerate(controls_a_animer):
        # CALCUL DE LA DURÉE D'ANIMATION
        
        if acceleration:
            # Facteur d'accélération : commence à 0.3 (rapide) et va jusqu'à 1.0 (+lent)
            # i / len(controls_a_animer) donne un pourcentage de progression (0 à 1)
            # * 0.7 le ramène de 0 à 0.7
            # + 0.3 le décale de 0.3 à 1.0
            # Résultat : première page rapide (duree*0.3), dernière lente (duree*1.0)
            facteur = 0.3 + (i / len(controls_a_animer)) * 0.7
            duree = int(duree_par_page * facteur)
        else:
            # Pas d'accélération : toutes les pages prennent le même temps
            duree = duree_par_page
        
        # CALCUL DE LA POSITION Y DE FIN
        
        # Position Y actuelle
        y_start = cmds.getAttr(f"{ctrl}.translateY")
        
        # Position Y finale : chaque page s'empile progressivement
        y_end = y_base + i * epaisseur
        
        # ANIMATION DE ROTATION (axe X)
        
        # Keyframe de départ : rotation à 0° (page horizontale)
        cmds.setKeyframe(ctrl, attribute='rotateX', value=0, time=frame_actuelle)
        
        # Frame de fin de cette animation
        frame_fin = frame_actuelle + duree
        
        # Keyframe de fin : rotation à 180° (page retournée)
        cmds.setKeyframe(ctrl, attribute='rotateX', value=180, time=frame_fin)
        
        # Appliquer une courbe spline pour un mouvement + fluide (pas linéaire)
        #'spline' crée une interpolation douce (courbe en S)
        # 'linear' serait une transition à vitesse constante (moins naturel)
        cmds.keyTangent(ctrl, attribute='rotateX', time=(frame_actuelle, frame_fin), inTangentType='spline', outTangentType='spline')
        
        # ANIMATION DE TRANSLATION Y (hauteur)
        
        # La page descend de sa position actuelle à sa position finale dans la pile
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_start, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_end, time=frame_fin)
        
        # Courbe fluide pour la descente
        cmds.keyTangent(ctrl, attribute='translateY', time=(frame_actuelle, frame_fin), inTangentType='spline', outTangentType='spline')
        
        # VARIATION ALÉATOIRE EN Z
        
        # Ajouter une légère torsion pendant le mouvement
        variation_z = random.uniform(-1, 1)  # Entre -1° et +1°
        
        # Au début : pas de rotation en Z
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_actuelle)
        
        # Au milieu du mouvement : légère rotation en Z
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=variation_z, time=frame_actuelle + duree//2)
        
        # À la fin : retour à 0
        cmds.setKeyframe(ctrl, attribute='rotateZ', value=0, time=frame_fin)
        
        # CHEVAUCHEMENT (OVERLAP)
        
        # La prochaine page commence 2 frames avant la fin de celle-ci
        frame_actuelle += duree - 2
    
    # Ajouter une pause de 20 frames à la fin
    frame_finale = frame_actuelle + 20
    
    # Mettre à jour la timeline de Maya pour afficher toute l'animation
    cmds.playbackOptions(minTime=frame_debut, maxTime=frame_finale)


def ralentir_pages(frame_debut_ralentissement, duree_ralentissement=30):
    """
    Ralentit progressivement l'animation des pages jusqu'à l'arrêt complet
    
    LOGIQUE :
    - Trouve toutes les pages qui ont encore des keyframes après frame_debut_ralentissement
    - Pour chaque page en mouvement :
      1. Récupère sa rotation/position actuelle à frame_debut_ralentissement
      2. Supprime toutes les keyframes futures (après cette frame)
      3. Crée une nouvelle keyframe de fin à frame_debut_ralentissement + duree_ralentissement
      4. La valeur de cette keyframe est la même que celle de départ
      5. Résultat : la page "gèle" progressivement sa rotation/position actuelle
    """
    
    # Vérifier que le rig existe
    if not cmds.objExists("Pages_RIG_GRP"):
        return
    
    # Récupérer tous les contrôleurs
    all_controls = cmds.listRelatives("Pages_RIG_GRP", children=True, type='transform')
    if not all_controls:
        return
    
    # Parcourir chaque contrôleur pour modifier son animation
    # On traite chaque contrôleur individuellement
    # Car certaines pages peuvent être immobiles, d'autres en mouvement
    for ctrl in all_controls:
        # TRAITEMENT DE LA ROTATION X
        
        # Détection des pages en mouvement :
        # On cherche s'il existe des keyframes après la frame de ralentissement
        # Si oui, cette page est encore en train de tourner et doit être ralentie
        keyframes_rotate = cmds.keyframe(ctrl, attribute='rotateX', query=True, time=(frame_debut_ralentissement, 100000))
        
        # Si des keyframes existent après cette frame
        if keyframes_rotate and len(keyframes_rotate) > 0:
            # Récupérer la valeur de rotation actuelle à frame_debut_ralentissement
            # time=... évalue l'attribut à cette frame spécifique
            rotation_actuelle = cmds.getAttr(f"{ctrl}.rotateX", time=frame_debut_ralentissement)
            
            # Supprimer toutes les keyframes futures sur rotateX
            # cutKey supprime les keyframes dans la plage de temps spécifiée
            # +0.01 pour ne pas supprimer la keyframe actuelle
            cmds.cutKey(ctrl, attribute='rotateX', time=(frame_debut_ralentissement + 0.01, 100000))
            
            # Calculer la frame de fin du ralentissement
            frame_fin = frame_debut_ralentissement + duree_ralentissement
            
            # Créer une nouvelle keyframe à frame_fin avec la valeur actuelle
            # La page va donc "geler" progressivement à cette rotation
            cmds.setKeyframe(ctrl, attribute='rotateX', value=rotation_actuelle, time=frame_fin)
            
            # Appliquer une tangente linéaire pour un ralentissement progressif
            # On utilise 'linear' plutôt que 'spline' pour un ralentissement uniforme
            # 'spline' créerait une courbe qui pourrait faire bouger un peu la page
            cmds.keyTangent(ctrl, attribute='rotateX', time=(frame_debut_ralentissement, frame_fin), outTangentType='linear')
        
        # TRAITEMENT DE LA TRANSLATION Y (même logique)
        
        keyframes_translate = cmds.keyframe(ctrl, attribute='translateY', query=True,
                                           time=(frame_debut_ralentissement, 100000))
        
        if keyframes_translate and len(keyframes_translate) > 0:
            y_actuelle = cmds.getAttr(f"{ctrl}.translateY", time=frame_debut_ralentissement)
            cmds.cutKey(ctrl, attribute='translateY', time=(frame_debut_ralentissement + 0.01, 100000))
            frame_fin = frame_debut_ralentissement + duree_ralentissement
            cmds.setKeyframe(ctrl, attribute='translateY', value=y_actuelle, time=frame_fin)
            cmds.keyTangent(ctrl, attribute='translateY', time=(frame_debut_ralentissement, frame_fin), outTangentType='linear')
        
        # TRAITEMENT DE LA ROTATION Z (même logique)
        
        keyframes_rotatez = cmds.keyframe(ctrl, attribute='rotateZ', query=True, time=(frame_debut_ralentissement, 100000))
        
        if keyframes_rotatez and len(keyframes_rotatez) > 0:
            rotatez_actuelle = cmds.getAttr(f"{ctrl}.rotateZ", time=frame_debut_ralentissement)
            cmds.cutKey(ctrl, attribute='rotateZ', time=(frame_debut_ralentissement + 0.01, 100000))
            frame_fin = frame_debut_ralentissement + duree_ralentissement
            cmds.setKeyframe(ctrl, attribute='rotateZ', value=rotatez_actuelle, time=frame_fin)
            cmds.keyTangent(ctrl, attribute='rotateZ',time=(frame_debut_ralentissement, frame_fin), outTangentType='linear')
    
    # Mettre à jour la timeline pour refléter la nouvelle durée
    # +10 frames de marge à la fin
    cmds.playbackOptions(maxTime=frame_debut_ralentissement + duree_ralentissement + 10)


creer_pages(nombre_pages=50)
rigger_pages()
animer_pages(nombre_pages_a_tourner=25, frame_debut=10, duree_par_page=10, acceleration=True)
ralentir_pages(frame_debut_ralentissement=100, duree_ralentissement=40)