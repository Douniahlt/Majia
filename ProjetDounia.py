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

    # Nettoie l'ancien rig s'il existe
    if cmds.objExists("Pages_RIG_GRP"):
        cmds.delete("Pages_RIG_GRP")

    # Créer un groupe vide qui contiendra toutes les pages
    pages_grp = cmds.group(empty=True, name="Pages_GRP")
    all_pages = []
    
    # Position fixe du bord de la reliure pour TOUTES les pages
    reliure_z = 3.3  # Position fixe en Z du bord de la reliure
    
    # Boucle pour créer chaque page
    for i in range(nombre_pages):
        # Variation aléatoire de la taille
        width = 9.4 - random.uniform(0, 0.1)  # Largeur entre 9.3 et 9.4
        depth = 6.6 - random.uniform(0, 0.1)  # Profondeur entre 6.5 et 6.6
        
        # Créer un cube plat pour représenter une page
        # [0] récupère le transform node
        page = cmds.polyCube(name=f"Page_{i+1:03d}", w=width, h=0.02, d=depth, sx=12, sy=12, sz=12)[0]      ###MODIFIE MODIFIE MODIFE
        
        # Positionner chaque page en hauteur pour créer la pile
        # L'espacement de 0.015 crée l'épaisseur de la pile
        y_pos = 0.42 + i * 0.015
        
        # Petite variation aléatoire en X
        x_offset = random.uniform(-0.05, 0.05)
        
        # CALCUL DE LA POSITION EN Z POUR ALIGNER LE BORD DE RELIURE
        # Comme le centre de la page est à z=0 par défaut et que depth varie,
        # on doit décaler la page pour que son bord (depth/2) soit toujours à reliure_z
        z_pos = reliure_z - depth/2
        
        # Déplacer la page à sa position finale
        cmds.move(x_offset, y_pos, z_pos, page)
        
        # PAS de rotation aléatoire en Y pour garder l'alignement du bord de reliure
        # cmds.rotate(0, random.uniform(-2, 2), 0, page)
        
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
        """pivot_y = cmds.getAttr(f"{une_page}.translateY")"""
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
        # La bounding box est une boîte invisible qui entoure parfaitement l'objet
        # Elle nous donne les coordonnées min/max de l'objet dans l'espace 3D
        # bbox = [xmin, ymin, zmin, xmax, ymax, zmax]
        bbox = cmds.exactWorldBoundingBox(page)
        
        # Position du pivot :
        # - En X : centre de la page (pour que la rotation soit centrée)
        pivot_x = (bbox[0] + bbox[3]) / 2
        
        # - En Y et Z : formules pour distribuer les locators en arc (demi-cercle vertical)
        # Extraction du numéro de page (Page_001 -> 0, Page_002 -> 1, etc.)
        page_index = int(page.split('_')[-1]) - 1  # n = numéro de la page
        
        # y = h / pi * sin( n * pi / (P - 1) )
        pivot_y = (hauteur_pages_totales / math.pi) * math.sin(page_index * math.pi / (nb_pages_total - 1))
        
        # z = lz + h / pi * ( cos( n * pi / (P - 1) ) - 1 )
        pivot_z = coordonnee_z + (hauteur_pages_totales / math.pi) * (math.cos(page_index * math.pi / (nb_pages_total - 1)) - 1)
        
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
    controls_a_animer = all_controls[(-nombre_pages_a_tourner-1):]
    
    # Inverser l'ordre pour commencer par la page la plus haute
    # Maintenant : Page_50_CTRL, Page_49_CTRL, ..., Page_36_CTRL
    controls_a_animer.reverse()
    
    all_bends = cmds.listRelatives("Bend_GRP", children=True, type='transform')
    if not all_bends:
        return

    bends_a_animer = all_bends[(-nombre_pages_a_tourner-1):]
    bends_a_animer.reverse()

    # PARAMÈTRES D'EMPILEMENT
    
    # Hauteur de base où les pages tournées vont s'empiler
    y_base = 0.42
    
    # Épaisseur entre chaque page empilée
    epaisseur = 0.015
    
    # Frame actuelle dans la timeline (on commence à frame_debut)
    frame_actuelle = frame_debut
    
    # BOUCLE D'ANIMATION DE CHAQUE PAGE

    # le temps augmente progressivement selon l’indice

    M = len(controls_a_animer)
    power = 10.6  # >1 = ralentissement plus marqué vers la fin

    # Sécurité
    if M <= temps_minimum_animation_page:
        durations = [max(temps_minimum_animation_page, int(duree_lente))] * M
    else:
        durations = []
        for i in range(M):
            t = (i / (M - 1)) ** power   # interpolation non linéaire
            dur = duree_normale + (duree_lente - duree_normale) * t
            durations.append(max(1, int(round(dur))))
    print("Durations list:", durations)

    # puis dans ta boucle d'animation, au lieu de calculer `duree` :

    for i, ctrl in enumerate(controls_a_animer):
        duree = durations[i] 
        # CALCUL DE LA DURÉE D'ANIMATION
        """
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
        """
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
        cmds.keyTangent(ctrl, attribute='rotateX', time=(frame_actuelle, frame_fin), 
                       inTangentType='spline', outTangentType='spline')
        
        # ANIMATION DE TRANSLATION Y (hauteur)
        
        # La page descend de sa position actuelle à sa position finale dans la pile
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_start, time=frame_actuelle)
        cmds.setKeyframe(ctrl, attribute='translateY', value=y_end, time=frame_fin)
        
        # Courbe fluide pour la descente
        cmds.keyTangent(ctrl, attribute='translateY', time=(frame_actuelle, frame_fin),
                       inTangentType='spline', outTangentType='spline')
        
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

    frame_actuelle = frame_debut

    M = len(bends_a_animer)
    power = 10.6  # >1 = ralentissement plus marqué vers la fin

    # Sécurité
    if M <= temps_minimum_animation_page:
        durations = [max(temps_minimum_animation_page, int(duree_lente))] * M
    else:
        durations = []
        for i in range(M):
            t = (i / (M - 1)) ** power   # interpolation non linéaire
            dur = duree_normale + (duree_lente - duree_normale) * t
            durations.append(max(1, int(round(dur))))
    print("Durations list:", durations)

    # puis dans ta boucle d'animation, au lieu de calculer `duree` :

    for j, bend in enumerate(bends_a_animer): 
        # CALCUL DE LA DURÉE D'ANIMATION
        duree = durations[j]
        """
        if acceleration:
            # Facteur d'accélération : commence à 0.3 (rapide) et va jusqu'à 1.0 (+lent)
            # i / len(bends_a_animer) donne un pourcentage de progression (0 à 1)
            # * 0.7 le ramène de 0 à 0.7
            # + 0.3 le décale de 0.3 à 1.0
            # Résultat : première page rapide (duree*0.3), dernière lente (duree*1.0)
            facteur = 0.3 + (j / len(bends_a_animer)) * 0.7
            duree = int(duree_par_page * facteur)
        else:
            # Pas d'accélération : tous les bends prennent le même temps
            duree = duree_par_page
        """
        # ANIMATION DE ROTATION (axe X)
        
        bend_node = cmds.listConnections(bend, type='nonLinear')[0]
        # Keyframe de départ : curvature à 0 (page horizontale)
        cmds.setKeyframe(bend_node, attribute="curvature", value=0, time=frame_actuelle)
        
        # Frame de fin de cette animation
        frame_fin = frame_actuelle + duree

        # Frame entre le début et la fin de cette animation
        frame_mid = (frame_actuelle + frame_fin) / 2
        
        cmds.setKeyframe(bend_node, attribute='curvature', value=100, time=frame_mid)
        cmds.setKeyframe(bend_node, attribute='curvature', value=0, time=frame_fin)

        # CHEVAUCHEMENT (OVERLAP)
        
        # La prochaine page commence 2 frames avant la fin de celle-ci
        frame_actuelle += duree - 2
    
    # Ajouter une pause de 20 frames à la fin
    frame_finale = frame_actuelle + 20
    
    # Mettre à jour la timeline de Maya pour afficher toute l'animation
    cmds.playbackOptions(minTime=frame_debut, maxTime=frame_finale)

# Temps total de l'animation(modifiable)
Temps_total = 150

#(modifiable)
nombre_pages = 50

#(modifiable) mais laisser le -1
nombre_pages_a_tourner=25-1
# Temps avant ouverture grimoire (modifiable)
frame_debut=10

# Pas moins de 4 sinon les pages on pas assez de temps pour tourner (pas touche !)
temps_minimum_animation_page = 4

# Calcul du nombre d'images pour tourner une page
duree_par_page=(Temps_total-frame_debut)//nombre_pages_a_tourner

#print("durées pages :", duree_par_page)

# Sécurité : pour que chaque page ait le temps minimum pour tourner
# Si t'as trop de pages à tourner par rapport au temps total on en tourne moins
if(duree_par_page < temps_minimum_animation_page):
    print("trop de pages à tourner pour le temps imparti")
    # Nouvelle valeur (celle minimum)
    duree_par_page = temps_minimum_animation_page
    # Calcul du nombre de pages à tourner (le max qu'on puisse faire sans bug avec le temps qu'on nous a donné)
    nombre_pages_a_tourner = (Temps_total - frame_debut) // temps_minimum_animation_page
    #print("nombre_pages_a_tourner :",nombre_pages_a_tourner)
    
# Temps total des pages sans le temps avant l'ouverture du grimoire
temps_total_mouvement = Temps_total - frame_debut

# Dernier 1/10 des pages = ralenties
nb_pages_lentes = max(1, nombre_pages_a_tourner // 10) #on peut changer le "10" pour modifier la proportion de pages ralenties mais faut changer les 20 % en 2* le nouveau nombre 
nb_pages_normales = nombre_pages_a_tourner - nb_pages_lentes

# Répartition du temps (20% pour pages lentes) donc les X dernières pages prennent 2 fois plus de temps
temps_pages_lentes = int(temps_total_mouvement * 0.20)
temps_pages_normales = temps_total_mouvement - temps_pages_lentes

# Durée par page
duree_normale = temps_pages_normales // nb_pages_normales
duree_lente = temps_pages_lentes // nb_pages_lentes

#print("Durée pages normales:", duree_normale)
#print("Durée pages lentes:", duree_lente)

# Variables globales pour le positionnement des locators en arc
hauteur_pages_totales = nombre_pages * 0.015  # h = hauteur totale quand le livre est fermé
nb_pages_total = nombre_pages  # P = nombre de pages total
coordonnee_z = 3.3  # lz = coordonnée z de la reliure (position de départ des locators)

creer_pages(nombre_pages)
rigger_pages()
animer_pages(nombre_pages_a_tourner, frame_debut, duree_normale, acceleration=False)