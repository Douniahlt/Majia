import maya.cmds as cmds
import maya.mel as mel
from random import *
from math import *


############################################################################################################################################
############################################################################################################################################


# INIT UTILITAIRE

lctr = "_lctr"
ctrl = "_ctrl"
grp = "_grp"
GRP = "_GRP"


# FONCTIONS UTILITAIRES

# Fonction qui comprend les fps de maya et rend un entier
def GetFpsNumber(name):
    FPS_MAP = {"game": 15, "film": 24, "pal": 25, "ntsc": 30, "show": 48, "palf": 50, "ntscf": 60}
    fps = FPS_MAP.get(name, 24) # Renvoie la valeur trouver dans le dictionnaire ou 24 s'il n'y avait pas de correspondance
    return fps

# Fonction qui trouve un mesh en ignorant les namespaces
def FindNodeIgnoreNamespace(name):
    scene = cmds.ls(type="transform")
    for node in scene:
        if node.split(":")[-1] == name:
            return node
    return None

# Fonction qui active ou désactive des field
def ToggleFields(isActive, textFieldList, intFieldList, floatFieldList):
    for f in textFieldList:
        cmds.textFieldGrp(f, edit=True, enable=isActive)
    for f in intFieldList:
        cmds.intSliderGrp(f, edit=True, enable=isActive)  
    for f in floatFieldList:
        cmds.floatSliderGrp(f, edit=True, enable=isActive)
    return None

# Calcul de la norme d'un vecteur : paramètre = liste de longueur 3
def VecNorm(v):
    return sqrt(v[0]**2 + v[1]**2 + v[2]**2)

# Normalisation de vecteur
def Normalize(v):
    norm = VecNorm(v)
    # Sécrurité si le vecteur est nul pour ne pas avoir à diviser par 0
    if norm == 0:
        return [0, 0, 1]
    # Sinon calcul du vecteur normalisé
    return [v[0]/norm, v[1]/norm, v[2]/norm]

# Déduit, d'une liste de vecteurs, la liste dérivées
def DerivVectorList(posListe):
    velListe = []

    # Tourne sur toutes les frames sauf la dernière pour éviter l'out of range
    for i in range(len(posListe)-1):
        # v = p(n+1) - p(n)
        vel = [posListe[i+1][0] - posListe[i][0],
               posListe[i+1][1] - posListe[i][1],
               posListe[i+1][2] - posListe[i][2]]
        velListe.append(vel)
    # Prend le vecteur de l'avant dernière frame pour la dernière frame aussi pour avoir un vecteur à chaque frame
    velListe.append(velListe[len(posListe)-2])

    return velListe


############################################################################################################################################
############################################################################################################################################


# Si le projet existe déjà, le supprimer pour le recréer
def ResetProject(mainGn):
    scene = cmds.ls(type="transform")  # Liste de tous les groupes dans la scène

    if(mainGn in scene):
        cmds.delete(mainGn)
        return True

    return False


# Fonction que check si les inputs de l'utilisateur pour la génération de place holders sont valides
def CheckProjectBodyValid():
    scene = cmds.ls(type="transform")

    # Vérifier que le nom du projet n'est pas vide
    projectName = cmds.textFieldGrp(projectName_field, q=True, text=True)
    if (projectName == ""):
        return False, "Project must have a name."

    # Vérifie si la frame range est possible
    animStart = cmds.intFieldGrp(animStart_field, q=True, value1=True)
    animEnd = cmds.intFieldGrp(animEnd_field, q=True, value1=True)
    if(animEnd <= animStart):
        return False, "Frame Range is not valid."

    # Vérifier que le fps est possible
    fps = cmds.intFieldGrp(fps_field, q=True, value1=True)
    if(fps <= 0):
        return False, "Frame Rate is not valid."

    # Vérifier que la target existe
    target = cmds.textFieldGrp(target_field, q=True, text=True)
    if not(target in scene):
        return False, "The specified target could not be found."

    return True, "No error found in Project Body Settings."


# Fonction que check si les inputs de l'utilisateur pour la génération des mesh sont valides
def CheckProjectMeshValid():
    scene = cmds.ls(type="transform")

    # Vérifier que le mesh existe
    meshToGenerate = cmds.textFieldGrp(meshToGenerate_field, q=True, text=True)
    if not(meshToGenerate in scene):
        return False, "The specified Mesh/Group Mesh could not be found."

    # Si l'utilisateur veut animer les ailes
    hasWings = cmds.checkBoxGrp(hasWings_field, q=True, value1=True)
    if(hasWings):

        # Vérifier que le mesh de l'aile gauche existe
        LWing = cmds.textFieldGrp(LWing_field, q=True, text=True)
        LWingName = FindNodeIgnoreNamespace(LWing)
        if not LWingName:
            return False, "The specified Left Wing Mesh could not be found."
        print("For Left Wing taking: ", LWingName)

        # Vérifie que l'aile est enfant du mesh
        parents = cmds.listRelatives(LWingName, allParents=True, fullPath=True) or []
        isChild = False
        for p in parents:
            if p.split("|")[-1] == meshToGenerate:
                isChild = True
                break
        if not isChild:
            return False, "Left Wing Mesh must be a child of the Mesh/Group Mesh."
        
        # Vérifier que le mesh de l'aile droite existe
        RWing = cmds.textFieldGrp(RWing_field, q=True, text=True)
        RWingName = FindNodeIgnoreNamespace(RWing)
        if not RWingName:
            return False, "The specified Right Wing Mesh does could not be found."
        print("For Right Wing taking: ", RWingName)

        # Vérifie que l'aile est enfant du mesh
        parents = cmds.listRelatives(RWingName, allParents=True, fullPath=True) or []
        isChild = False
        for p in parents:
            if p.split("|")[-1] == meshToGenerate:
                isChild = True
                break
        if not isChild:
            return False, "Right Wing Mesh must be a child of the Mesh/Group Mesh."

    return True, "No error found in Project Mesh Settings."


############################################################################################################################################
############################################################################################################################################


# Anime un controller tourant et s'approchant aléatoirement autour du centre du monde
def AnimRandAtWorldCenter(controller, attToNoise, animStart, animEnd, smoothCrv, sampleCrv):

    # Animation
    for key in attToNoise:

        # Init les infos de la liste déclarée plus tôt pour chaque attribut à noiser
        (action, attname, nbFrame, Nmin, Nmax) = key
        att = controller + "." + attname

        # Liste aléatoire de frames où poser des clefs entre le debut et la fin de l'anim
        frameL = [animStart, animEnd]
        for i in range(nbFrame):
            frame = randint(animStart, animEnd+1)
            frameL.append(frame)

        # Placement des clefs avec des valeurs au hasard
        for frame in frameL:
            x = uniform(Nmin, Nmax)
            cmds.currentTime(frame)
            action(x, x, x, controller, a=True)
            cmds.setKeyframe(att)

    # Clean
    cmds.scale(x, 1, 1, controller, a=True) # Remet le scale des coordonnées non keyées à 0 pour pas déformer les controllers
    # Smooth des curves d'anim pour éviter d'avoir des mouvements trop brutaux
    toSmoothL = []
    for key in attToNoise:
        toSmoothL.append(controller + "_" + key[1])
    cmds.filterCurve(*toSmoothL, cof=smoothCrv, f="butterworth", sr=sampleCrv)

    return None


# Crée le nombre de "mini rigs" demandé par l'utilisateur en fonction des paramètres de noises
def CreateMotionAtWorldCenter(nbPaths, phPref, animPhPref, attToNoise, animStart, animEnd, smoothCrv, sampleCrv, rootPh):

    # Créer le nombre d'animations choisi par l'utilisateur
    for i in range(nbPaths):

        # Générer les noms
        number = f"{i+1:02d}"  # convertit i en string avec padding de 2
        child = phPref + number + lctr
        parent = animPhPref + number + ctrl

        # Créer la mini hiérarchie avec le locator et son controller
        cmds.group(n=parent, em=True, w=True)
        cmds.spaceLocator(n=child)
        cmds.xform(child, ws=True, t=[1,0,0])
        cmds.parent(child, parent)

        # Animation
        AnimRandAtWorldCenter(parent, attToNoise, animStart, animEnd, smoothCrv, sampleCrv)

    # Clean de la scène = tout grouper dans le root
    cmds.group(n=rootPh, em=True, w=True)
    cmds.parent(cmds.ls(animPhPref + "*", type="transform"), rootPh)

    return None


############################################################################################################################################
############################################################################################################################################


# Crée la liste des positions d'un obj à toutes les frames entre animStart et animEnd
def ListTargetPos(target, animStart, animEnd):

    posListe = []
    for frame in range(animStart, animEnd+1):
        cmds.currentTime(frame)
        position = cmds.xform(target, q=True, t=True, ws=True)
        posListe.append(position)

    return posListe


# Place le root des mini rigs sur la traget en le retardant si nécessaire et pose des clefs
def FollowTarget(follower, target, late, animStart, animEnd):

    posListe = ListTargetPos(target, animStart, animEnd)

    for frame in range(animStart, animEnd+1):
        # Chercher la position à copier en prenant en compte le retard
        idx = frame - animStart - late
        if(idx < animStart):
            idx = animStart
        if(idx > animEnd):
            idx = animEnd

        # Placer les clefs
        cmds.currentTime(frame)
        cmds.move(*posListe[idx], follower)
        cmds.setKeyframe(follower, at="translate")

    return posListe


############################################################################################################################################
############################################################################################################################################


# Prépare le mesh qu'on veut placer sur les places holders, en créant des copies et en les scalant aléatoirement
def PrepMesh(mesh, nameRoot, sMin, sMax):

    # Scale aléatoire
    randS = uniform(sMin, sMax)
    cmds.scale(randS, randS, randS, mesh)

    # Tout mettre dans un groupe pour pas casser la hiérarchie
    cmds.group(n=nameRoot, em=True, w=True)
    cmds.parent(mesh, nameRoot)

    return None


# Rotate un mesh "follower" pour qu'il s'oriente selon sa vitesse
def OrientToVel(follower, posListe, animStart, animEnd):
    # Crée la liste des vitesses
    velListe = DerivVectorList(posListe)
    
    for frame in range(animStart, animEnd+1):
        idx = frame - animStart # Les indexes sont décalés si animStart n'est pas égal à 0
        cmds.currentTime(frame)
        
        vel = velListe[idx]
        dirVel = Normalize(vel)
        
        # Calcul de la rotation en radians
        rotX = -atan2(dirVel[1], sqrt(dirVel[0]**2 + dirVel[2]**2))  # X = inclinaison
        rotY = atan2(dirVel[0], dirVel[2])  # angle entre l'axe X et la vel projetée dans XZ
        
        # Conversion en degrés
        rotX = degrees(rotX)
        rotY = degrees(rotY)
        rotZ = 0  # pas de rotation sur Z
        
        # Appliquer la rotation et mettre une clef
        cmds.rotate(rotX, rotY, rotZ, follower, a=True)
        cmds.setKeyframe(follower, at="rotate")

    return velListe


# Anime les ailes en fonction de la vitesse (si la vitesse est plus basse qu'un threshold donné par l'utilisateur, les ailes ne bougent pas)
def AnimWingsToAcc(accListe, wingMesh, isRight, angleMin, angleMax, animStart, animEnd, accThreshold, wingSpeed):

    # Init des angles extrêmaux de la rotation des ailes
    bottom = angleMin
    top =  angleMax
    # Si on anime l'aile droite, il faut inverser les angles de rotation de l'aile
    if(isRight):
        bottom = -bottom
        top = -top

    # Cherche quand la vitesse est plus grande que le threshold d'anim en parcourant toutes les frames
    frame = animStart
    while(frame < animEnd + 1):

        acc = VecNorm(accListe[frame - animStart])

        if(acc < accThreshold):
            # Si la vitesse est trop petite on va checker la frame suivante
            frame += 1

        else:
            # Si la vitesse est assez grande, on anime l'aile tant que la vitesse reste assez grande
            isTop = True # pour alterner entre l'angle vers le haut et vers le bas

            while(acc > accThreshold and frame < animEnd + 1):

                # On place la clef à la frame actuel
                cmds.currentTime(frame)
                if(isTop):
                    cmds.rotate(0, top, 0, wingMesh, a=True)
                else:
                    cmds.rotate(0, bottom, 0, wingMesh, a=True)
                cmds.setKeyframe(wingMesh, at="rotate")

                # On va à la frame où on placerait la clef suivante et on toggle isTop
                frame += wingSpeed + randint(-2, 1)
                isTop = not isTop

                # On check si on est toujours dans le frame range, puis si la nouvelle vitesse est toujours sous le threshold
                if(frame < animEnd + 1):
                    acc = VecNorm(accListe[frame - animStart])

            # Quand la vel passe sous le threshold on remet une clef à 0
            cmds.currentTime(frame)
            cmds.rotate(0, 0, 0, wingMesh, a=True)
            cmds.setKeyframe(wingMesh, at="rotate")

            # Puis on va checker la frame suivante
            frame += 1
    
    return None



# Crée un mesh pour chaque place holder et bake l'animation des place holders sur un controller parent du mesh
def BakeToMesh(hasWings, phPref, geoMshPref, animMshPref, meshToGenerate, animStart, animEnd, RWing, LWing, mainGn, angleMin, angleMax, accThreshold, wingSpeed, sMin, sMax):

    # Liste de tous les places holders sur lesquels placer un mesh
    targetList = cmds.ls(phPref + "*", type="transform")

    # Tourne sur chaque place holder
    for i in range(len(targetList)):
        target = targetList[i]

        # Créer une copie et une hiérarchie pour chaque point
        number = f"{i+1:02d}"
        nameMode = geoMshPref + number + grp
        nameAnim = animMshPref + number + ctrl

        # Créer un nouvel examplaire du mesh à baker
        cmds.duplicate(meshToGenerate, n=nameMode)

        # Prep le nouveau mesh
        PrepMesh(nameMode, nameAnim, sMin, sMax)

        # Translate : placer les mesh sur le même translate que les place holders
        posListe = FollowTarget(nameAnim, target, 0, animStart, animEnd)

        # Rotate : orienter les mesh selon la vitesse
        velListe = OrientToVel(nameAnim, posListe, animStart, animEnd)

        if(hasWings):  # Seulement si l'utilisateur veut animer les ailes
            # Anim les ailes en fonction de l'accélération (dérivée de la vitesse)
            accListe = DerivVectorList(velListe)
            # Aile droite
            tofind = nameMode + "|" + RWing # Trouver le bon mesh de l'aile
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToAcc(accListe, wingMesh, False, angleMin, angleMax, animStart, animEnd, accThreshold, wingSpeed)
            # Aile gauche
            tofind = nameMode + "|" + LWing
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToAcc(accListe, wingMesh, True, angleMin, angleMax, animStart, animEnd, accThreshold, wingSpeed)

    # Clean = tout mettre dans un groupe principal
    cmds.group(n=mainGn, em=True, w=True)
    cmds.parent(cmds.ls(animMshPref + "*", type='transform'), mainGn)
        
    return None


############################################################################################################################################
############################################################################################################################################


# Fonction qui récupère les inputs saisis par l'utilisateur dans l'interface
def GetUserInputs():

    # Récupère le nom du projet
    projectName = cmds.textFieldGrp(projectName_field, q=True, text=True)

    # Init les noms
    mainGn = "GENERATOR_" + projectName.upper() + GRP
    phPref = projectName + "_placeHolder"
    animPhPref = projectName + "_anim_" + phPref
    rootPh = projectName + "_root_" + phPref + ctrl
    geoMshPref = "geo_" + projectName
    animMshPref = "anim_" + projectName

    # Récupère le reste des General Options
    animStart = cmds.intFieldGrp(animStart_field, q=True, value1=True)
    animEnd = cmds.intFieldGrp(animEnd_field, q=True, value1=True)
    fps = cmds.intFieldGrp(fps_field, q=True, value1=True)

    # Récupère les Random Motion at World Center Options
    nbPaths = cmds.intSliderGrp(nbPaths_field, q=True, value=True)

    # Noise Frequencies
    rNoiseFreq = cmds.floatSliderGrp(rNoiseFreq_field, q=True, value=True)
    sNoiseFreq = cmds.floatSliderGrp(sNoiseFreq_field, q=True, value=True)
    sNoiseMin = cmds.floatSliderGrp(sNoiseMin_field, q=True, value=True)
    sNoiseMax = cmds.floatSliderGrp(sNoiseMax_field, q=True, value=True)
    # Nombres de keys qu'il faudra poser pour les aléatoires en fonction de ce qu'a choisi l'utilisateur
    rNbFrames = int((animEnd - animStart) / fps * rNoiseFreq)  # Pour la rotation
    sNbFrames = int((animEnd - animStart) / fps * sNoiseFreq)  # Pour le scaling
    # Listes des attributs sur lesquels il faut mettre des keys aléatoires avec les paramètres qui servent à faire tourner la fonction AnimRandAtWorldCenter
        # [action, "attribut", nb de frames à keyer, minimum du noise, maximum du noise]
    attToNoise = [[cmds.rotate, "rotateX", rNbFrames, -180, 180],
                  [cmds.rotate, "rotateY", rNbFrames, -180, 180],
                  [cmds.rotate, "rotateZ", rNbFrames, -180, 180],
                  [cmds.scale, "scaleX", sNbFrames, sNoiseMin, sNoiseMax]]

    # Noise Smoothing
    smoothCrv = cmds.floatSliderGrp(smoothCrv_field, q=True, value=True)
    sampleCrv = cmds.floatSliderGrp(sampleCrv_field, q=True, value=True)

    # Récupère Target Following Options
    target = cmds.textFieldGrp(target_field, q=True, text=True)
    lateToTarget = cmds.intSliderGrp(lateToTarget_field, q=True, value=True)

    # Récupère Mesh Animation Options
    meshToGenerate = cmds.textFieldGrp(meshToGenerate_field, q=True, text=True)
    sMin = cmds.floatSliderGrp(sMin_field, q=True, value=True)
    sMax = cmds.floatSliderGrp(sMax_field, q=True, value=True)

    # Récupère Wing Animation
    hasWings = cmds.checkBoxGrp(hasWings_field, q=True, value1=True)

    LWing = cmds.textFieldGrp(LWing_field, q=True, text=True)
    RWing = cmds.textFieldGrp(RWing_field, q=True, text=True)

    accThreshold = cmds.floatSliderGrp(accThreshold_field, q=True, value=True)
    wingSpeed = cmds.intSliderGrp(wingSpeed_field, q=True, value=True)
    angleMin = cmds.floatSliderGrp(angleMin_field, q=True, value=True)
    angleMax = cmds.floatSliderGrp(angleMax_field, q=True, value=True)

    # Débug
    print(mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, accThreshold, wingSpeed, angleMin, angleMax)

    # Retourne tout
    return mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, accThreshold, wingSpeed, angleMin, angleMax


############################################################################################################################################
############################################################################################################################################


# Fonction qui cherche le projet et le supprime si elle le trouve
def BugFlowDel():
    projectName = cmds.textFieldGrp(projectName_field, q=True, text=True)
    mainGn = "GENERATOR_" + projectName.upper() + GRP

    exists = ResetProject(mainGn)

    if exists:
        cmds.inViewMessage(amg="Project was successfully deleted.", bkc=0x319731, pos="midCenter", fade=True)
    else:
        cmds.inViewMessage(amg="Project was not deleted: it could not be found.", bkc=0xA03C3C, pos="midCenter", fade=True)

    return None


# Fonction qui ne génère que les place holders mais pas les mesh
def BugFlowPlaceHolders():

    # Checker si les inputs de l'utilisateur vont créer une erreur et bloquer si c'est le cas
    isValid, error = CheckProjectBodyValid()
    if not isValid:
        print(error)
        cmds.inViewMessage(amg=error, bkc=0xA03C3C, pos="midCenter", fade=True)
        return None
    print(error)

    # Garder en mémoire l'était de l'autokey et le désactiver
    autokey = bool(mel.eval('autoKeyframe -q -state;'))
    mel.eval("autoKeyframe -state 0;")

    # Récupérer les inputs de l'utilisateur
    mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, accThreshold, wingSpeed, angleMin, angleMax = GetUserInputs()

    # Update ou création = si le projet existe déjà, le supprimer pour le recréer
    ResetProject(mainGn)

    # Création du bon nombre de points qui tournent autour du centre du monde
    CreateMotionAtWorldCenter(nbPaths, phPref, animPhPref, attToNoise, animStart, animEnd, smoothCrv, sampleCrv, rootPh)

    # Animation du centre de l'animation pour qu'il suive la target avec un retard
    FollowTarget(rootPh, target, lateToTarget, animStart, animEnd)

    # Ré activer l'autokey s'il était activé au départ
    if(autokey):
        mel.eval("autoKeyframe -state 1;")

    # Message de fin d'éxecution
    cmds.inViewMessage(amg="Project was successfully created", bkc=0x319731, pos="midCenter", fade=True)

    return None

def BugFlowMeshes():

    # Checker si les inputs de l'utilisateur vont créer une erreur et bloquer si c'est le cas
    isValid, error = CheckProjectBodyValid()
    if not isValid:
        print(error)
        cmds.inViewMessage(amg=error, bkc=0xA03C3C, pos="midCenter", fade=True)
        return None
    print(error)

    # Garder en mémoire l'était de l'autokey et le désactiver
    autokey = bool(mel.eval('autoKeyframe -q -state;'))
    mel.eval("autoKeyframe -state 0;")

    # Récupérer les inputs de l'utilisateur
    mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, accThreshold, wingSpeed, angleMin, angleMax = GetUserInputs()

    # Placer les modèles de papythons sur les points animés
    BakeToMesh(hasWings, phPref, geoMshPref, animMshPref, meshToGenerate, animStart, animEnd, RWing, LWing, mainGn, angleMin, angleMax, accThreshold, wingSpeed, sMin, sMax)

    # Clean final
    cmds.parent(rootPh, mainGn) # Mettre le rig des place holder dans le groupe principal du projet
    cmds.hide(rootPh) # et le cacher

    # Ré activer l'autokey s'il était activé au départ
    if(autokey):
        mel.eval("autoKeyframe -state 1;")

    # Message de fin d'éxecution
    cmds.inViewMessage(amg="Project was successfully created", bkc=0x319731, pos="midCenter", fade=True)

    return None

def BugFlowGen():

    # Checker si les inputs de l'utilisateur vont créer une erreur et bloquer si c'est le cas
    isValid, error = CheckProjectBodyValid()
    if not isValid:
        print(error)
        cmds.inViewMessage(amg=error, bkc=0xA03C3C, pos="midCenter", fade=True)
        return None
    print(error)
    isValid, error = CheckProjectMeshValid()
    if not isValid:
        print(error)
        cmds.inViewMessage(amg=error, bkc=0xA03C3C, pos="midCenter", fade=True)
        return None
    print(error)

    # Garder en mémoire l'était de l'autokey et le désactiver
    autokey = bool(mel.eval('autoKeyframe -q -state;'))
    mel.eval("autoKeyframe -state 0;")
    
    # Récupérer les inputs de l'utilisateur
    mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, accThreshold, wingSpeed, angleMin, angleMax = GetUserInputs()

    # Update ou création = si le projet existe déjà, le supprimer pour le recréer
    ResetProject(mainGn)

    # Création du bon nombre de points qui tournent autour du centre du monde
    CreateMotionAtWorldCenter(nbPaths, phPref, animPhPref, attToNoise, animStart, animEnd, smoothCrv, sampleCrv, rootPh)

    # Animation du centre de l'animation pour qu'il suive la target avec un retard
    FollowTarget(rootPh, target, lateToTarget, animStart, animEnd)

    # Placer les modèles de papythons sur les points animés
    BakeToMesh(hasWings, phPref, geoMshPref, animMshPref, meshToGenerate, animStart, animEnd, RWing, LWing, mainGn, angleMin, angleMax, accThreshold, wingSpeed, sMin, sMax)

    # Clean final
    cmds.parent(rootPh, mainGn) # Mettre le rig des place holder dans le groupe principal du projet
    cmds.hide(rootPh) # et le cacher

    # Ré activer l'autokey s'il était activé au départ
    if(autokey):
        mel.eval("autoKeyframe -state 1;")

    # Message de fin d'éxecution
    cmds.inViewMessage(amg="Project was successfully created", bkc=0x319731, pos="midCenter", fade=True)

    return None


############################################################################################################################################
############################################################################################################################################


# INTERFACE

# Si la fenêtre existe déjà on la ferme
if cmds.window("BugFlowGenWindow", exists=True):
    cmds.deleteUI("BugFlowGenWindow")

# Mise en page de la fenêtre
window = cmds.window("BugFlowGenWindow", title="Bug Flow Generator", widthHeight=(500, 300))
parent = cmds.columnLayout(adj=True, width=500)

cmds.scrollLayout()

# 0. General Options

projectName_field = cmds.textFieldGrp(label="Project Name", text="DefaultProject")  # Les noms de groupes et controllers dépendront de ce nom
                                                                                    # Il sert aussi à identifier si le projet existe déjà et qu'il faut le remplacer ou s'il faut juste le créer
startTL = cmds.playbackOptions(q=True, min=True)
animStart_field = cmds.intFieldGrp(label="Start Frame", value1=startTL)

endTL = cmds.playbackOptions(q=True, max=True)
animEnd_field = cmds.intFieldGrp(label="End Frame", value1=endTL)

fpsTL = GetFpsNumber(cmds.currentUnit(q=True, time=True))
fps_field = cmds.intFieldGrp(label="Frame Rate", value1=fpsTL)

# 1. Random Motion at World Center Options

cmds.frameLayout(label="Random Motion Options", cll=True, mw=10)

nbPaths_field = cmds.intSliderGrp(label="Number of Bugs", f=True, min=1, max=20, fmn=1, fmx=100, value=3)   # Nombre de mesh à animer

# 1.a. Noises frequencies

cmds.frameLayout(label="Noises Options", cll=True, mw=20)

rNoiseFreq_field = cmds.floatSliderGrp(label="Rotation Noise Freq", f=True, min=.001, max=2, fmn=.001, fmx=10, value=1, precision=3)  # Fréquence du noise sur la rotation des place holders autour de la cible

sNoiseFreq_field = cmds.floatSliderGrp(label="Distance to Target Noise Freq", f=True, min=.001, max=2, fmn=.001, fmx=10, value=1, precision=3) # Fréquence du noise sur l'éloignement puis rapprochement des place holders à la cible
sNoiseMin_field = cmds.floatSliderGrp(label="Min Distance to Target", f=True, min=0, max=10, fmn=0, fmx=100, value=1, precision=3)    # Rapprochement maximal
sNoiseMax_field = cmds.floatSliderGrp(label="Max Distance to Target", f=True, min=0, max=10, fmn=0, fmx=100, value=3, precision=3)    # Eloignement maximal

cmds.setParent("..")

# 1.b. Noises smoothing

cmds.frameLayout(label="Noise Smoothing Options", cll=True, mw=20)

smoothCrv_field = cmds.floatSliderGrp(label="Cutoff Frequency", f=True, min=.001, max=30, fmn=0, fmx=30, value=1.75, precision=3) # Niveau de smooth sur les courbes d'animation noisées (30 = pas smoothée, 0 = très smoothée)
sampleCrv_field = cmds.floatSliderGrp(label="Sampling Rate", f=True, min=1, max=100, fmn=1, fmx=100, value=6.5, precision=3) # Niveau de simplification de la courbe, ie supprimer les clefs

cmds.setParent("..")

cmds.setParent("..")

# 2. Target Following Options

cmds.frameLayout(label="Noise Smoothing Options", cll=True, mw=10)

target_field = cmds.textFieldGrp(label="Target Name", text="target_lctr")   # Nom du point que les mesh doivent suivrent
lateToTarget_field = cmds.intSliderGrp(label="Frame Delay", f=True, min=-25, max=25, fmn=-1000, fmx=1000, value=5) # Nombre de frames de retard de l'animation du la courbe

cmds.setParent("..")

# 3. Mesh Animation Options

cmds.frameLayout(label="Mesh Animation Options", cll=True, mw=10)

meshToGenerate_field = cmds.textFieldGrp(label="Mesh/Group Mesh Name", text="papython:papython_grp")    # Nom du mesh sur lequel faire tourner la génération

sMin_field = cmds.floatSliderGrp(label="Min Mesh Scale", f=True, min=0, max=5, fmn=0, fmx=1000, value=.2, precision=3) # Scaling minimal du mesh
sMax_field = cmds.floatSliderGrp(label="Max Mesh Scale", f=True, min=0, max=5, fmn=0, fmx=1000, value=.4, precision=3) # Scaling maximal du mesh

# 3.a. Wing Animation

cmds.frameLayout(label="Wings Animation Options", cll=True, mw=20)

hasWings_field = cmds.checkBoxGrp(label="Animate Wings", value1=True, changeCommand=(lambda x: ToggleFields(x, [LWing_field, RWing_field], [wingSpeed_field], [accThreshold_field, angleMin_field, angleMax_field])))   # Choisit s'il y a des ailes à animer ou non

LWing_field = cmds.textFieldGrp(label="Left Wing Mesh Name", text="L_wing_msh") # Nom des ailes pour l'animation
RWing_field = cmds.textFieldGrp(label="Right Wing Mesh Name", text="R_wing_msh")

accThreshold_field = cmds.floatSliderGrp(label="Anim Accel Threshold", f=True, min=0, max=1, fmn=0, fmx=1000, value=.075, precision=3) # Vitesse à partir de laquelle les ailes sont animées
wingSpeed_field = cmds.intSliderGrp(label="Wing Mouvement Duration", f=True, min=1, max=10, fmn=1, fmx=1000, value=4)    # Nombre de frames entre les deux positions d'animation des ailes
angleMin_field = cmds.floatSliderGrp(label="Wings Down Pos Angle", f=True, min=-180, max=0, fmn=-180, fmx=0, value=-65, precision=3) # Angle pour la position extrêmale basse des ailes
angleMax_field = cmds.floatSliderGrp(label="Wings Up Pos Angle", f=True, min=0, max=180, fmn=0, fmx=180, value=50, precision=3) # Position extrêmale haute

cmds.setParent(parent)

# 4. Buttons

cmds.button(label="Generate or Update", command=lambda x: BugFlowGen())
cmds.button(label="Only Generate Place Holders", command=lambda x: BugFlowPlaceHolders())
cmds.button(label="Re Animate Meshes", command=lambda x: BugFlowMeshes())
cmds.button(label="Delete Project", command=lambda x: BugFlowDel())

cmds.showWindow(window)