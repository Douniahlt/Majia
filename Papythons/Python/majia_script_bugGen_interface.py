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
    allTransfL = cmds.ls(type="transform")  # Liste de tous les groupes dans la scène

    if(mainGn in allTransfL):
        cmds.delete(mainGn)

    return None


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
def AnimWingsToVel(velListe, wingMesh, isRight, angleMin, angleMax, animStart, animEnd, velThreshold, wingSpeed):

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

        vel = VecNorm(velListe[frame - animStart])

        if(vel < velThreshold):
            # Si la vitesse est trop petite on va checker la frame suivante
            frame += 1

        else:
            # Si la vitesse est assez grande, on anime l'aile tant que la vitesse reste assez grande
            isTop = True # pour alterner entre l'angle vers le haut et vers le bas

            while(vel > velThreshold and frame < animEnd + 1):

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
                    vel = VecNorm(velListe[frame - animStart])

            # Quand la vel passe sous le threshold on remet une clef à 0
            cmds.currentTime(frame)
            cmds.rotate(0, 0, 0, wingMesh, a=True)
            cmds.setKeyframe(wingMesh, at="rotate")

            # Puis on va checker la frame suivante
            frame += 1
    
            return None


# Prépare le mesh qu'on veut placer sur les places holders, en créant des copies et en les scalant aléatoirement
def PrepMesh(mesh, nameRoot, sMin, sMax):

    # Scale aléatoire
    randS = uniform(sMin, sMax)
    cmds.scale(randS, randS, randS, mesh)

    # Tout mettre dans un groupe pour pas casser la hiérarchie
    cmds.group(n=nameRoot, em=True, w=True)
    cmds.parent(mesh, nameRoot)

    return None


# Crée un mesh pour chaque place holder et bake l'animation des place holders sur un controller parent du mesh
def BakeToMesh(hasWings, phPref, geoMshPref, animMshPref, meshToGenerate, animStart, animEnd, RWing, LWing, mainGn, angleMin, angleMax, velThreshold, wingSpeed, sMin, sMax):

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
            # Anim les ailes en fonction de la vitesse
            # Aile droite
            tofind = nameMode + "|" + RWing # Trouver le bon mesh de l'aile
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToVel(velListe, wingMesh, False, angleMin, angleMax, animStart, animEnd, velThreshold, wingSpeed)
            # Aile gauche
            tofind = nameMode + "|" + LWing
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToVel(velListe, wingMesh, True, angleMin, angleMax, animStart, animEnd, velThreshold, wingSpeed)

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
    sNoiseMin = cmds.floatFieldGrp(sNoiseMin_field, q=True, value1=True)
    sNoiseMax = cmds.floatFieldGrp(sNoiseMax_field, q=True, value1=True)
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
    sMin = cmds.floatFieldGrp(sMin_field, q=True, value1=True)
    sMax = cmds.floatFieldGrp(sMax_field, q=True, value1=True)

    # Récupère Wing Animation
    hasWings = cmds.checkBoxGrp(hasWings_field, q=True, value1=True)

    LWing = cmds.textFieldGrp(LWing_field, q=True, text=True)
    RWing = cmds.textFieldGrp(RWing_field, q=True, text=True)

    velThreshold = cmds.floatFieldGrp(velThreshold_field, q=True, value1=True)
    wingSpeed = cmds.intFieldGrp(wingSpeed_field, q=True, value1=True)
    angleMin = cmds.floatSliderGrp(angleMin_field, q=True, value=True)
    angleMax = cmds.floatSliderGrp(angleMax_field, q=True, value=True)

    # Débug
    print(mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, velThreshold, wingSpeed, angleMin, angleMax)

    # Retourne tout
    return mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, velThreshold, wingSpeed, angleMin, angleMax


############################################################################################################################################
############################################################################################################################################


def BugFlowGen():

    # Garder en mémoire l'était de l'autokey et le désactiver
    autokey = bool(mel.eval('autoKeyframe -q -state;'))
    mel.eval("autoKeyframe -state 0;")
    
    mainGn, phPref, animPhPref, rootPh, geoMshPref, animMshPref, animStart, animEnd, nbPaths, attToNoise, smoothCrv, sampleCrv, target, lateToTarget, meshToGenerate, sMin, sMax, hasWings, LWing, RWing, velThreshold, wingSpeed, angleMin, angleMax = GetUserInputs()

    # Update ou création = si le projet existe déjà, le supprimer pour le recréer
    ResetProject(mainGn)

    # Création du bon nombre de points qui tournent autour du centre du monde
    CreateMotionAtWorldCenter(nbPaths, phPref, animPhPref, attToNoise, animStart, animEnd, smoothCrv, sampleCrv, rootPh)

    # Animation du centre de l'animation pour qu'il suive la target avec un retard
    FollowTarget(rootPh, target, lateToTarget, animStart, animEnd)

    # Placer les modèles de papythons sur les points animés
    BakeToMesh(hasWings, phPref, geoMshPref, animMshPref, meshToGenerate, animStart, animEnd, RWing, LWing, mainGn, angleMin, angleMax, velThreshold, wingSpeed, sMin, sMax)

    # Clean final
    cmds.parent(rootPh, mainGn) # Mettre le rig des place holder dans le groupe principal du projet
    cmds.hide(rootPh) # et le cacher

    # Ré activer l'autokey s'il était activé au départ
    if(autokey):
        mel.eval("autoKeyframe -state 1;")

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

projectName_field = cmds.textFieldGrp(label="Project Name", text="Project")

startTL = cmds.playbackOptions(q=True, min=True)
animStart_field = cmds.intFieldGrp(label="Start Frame", value1=startTL)

endTL = cmds.playbackOptions(q=True, max=True)
animEnd_field = cmds.intFieldGrp(label="End Frame", value1=endTL)

fpsTL = GetFpsNumber(cmds.currentUnit(q=True, time=True))
fps_field = cmds.intFieldGrp(label="Frame Rate", value1=fpsTL)

# 1. Random Motion at World Center Options

cmds.frameLayout(label="Random Motion Options", cll=True, mw=10)

nbPaths_field = cmds.intSliderGrp(label="Number of Bugs", f=True, fmn=1, fmx=20, value=2)

# 1.a. Noises frequencies

cmds.frameLayout(label="Noises Options", cll=True, mw=20)

rNoiseFreq_field = cmds.floatSliderGrp(label="Rotation Noise Freq", f=True, fmn=0, fmx=1, value=1)

sNoiseFreq_field = cmds.floatSliderGrp(label="Distance to Target Noise Freq", f=True, fmn=0, fmx=1, value=1)
sNoiseMin_field = cmds.floatFieldGrp(label="Min Distance to Target", value1=1)
sNoiseMax_field = cmds.floatFieldGrp(label="Max Distance to Target", value1=3)

cmds.setParent("..")

# 1.b. Noises smoothing

cmds.frameLayout(label="Noise Smoothing Options", cll=True, mw=20)

smoothCrv_field = cmds.floatSliderGrp(label="Cutoff Frequency", f=True, fmn=.1, fmx=30, value=1.75)
sampleCrv_field = cmds.floatSliderGrp(label="Sampling Rate", f=True, fmn=1, fmx=100, value=6.5)

cmds.setParent("..")

cmds.setParent("..")

# 2. Target Following Options

cmds.frameLayout(label="Noise Smoothing Options", cll=True, mw=10)

target_field = cmds.textFieldGrp(label="Target Name", text="target_lctr")
lateToTarget_field = cmds.intSliderGrp(label="Frame Delay", f=True, fmn=0, fmx=30, value=5) 

cmds.setParent("..")

# 3. Mesh Animation Options

cmds.frameLayout(label="Mesh Animation Options", cll=True, mw=10)

meshToGenerate_field = cmds.textFieldGrp(label="Mesh Name")

sMin_field = cmds.floatFieldGrp(label="Min Mesh Scale", value1=.2)
sMax_field = cmds.floatFieldGrp(label="Max Mesh Scale", value1=.4)

# 3.a. Wing Animation

cmds.frameLayout(label="Wings Animation Options", cll=True, mw=20)

hasWings_field = cmds.checkBoxGrp(label="Animate Wings", value1=True)

LWing_field = cmds.textFieldGrp(label="Left Wing Mesh Name", text="L_wing_msh")
RWing_field = cmds.textFieldGrp(label="Right Wing Mesh Name", text="R_wing_msh")

velThreshold_field = cmds.floatFieldGrp(label="Anim Acc Threshold", value1=.15)
wingSpeed_field = cmds.intFieldGrp(label="Wings Speed", value1=4)
angleMin_field = cmds.floatSliderGrp(label="Wings Down Position Angle", f=True, fmn=-180, fmx=0, value=-65)
angleMax_field = cmds.floatSliderGrp(label="Wings Up Position Angle", f=True, fmn=0, fmx=180, value=50)

cmds.setParent(parent)

# 4. Buttons

cmds.button(label="Generate", command=lambda x: BugFlowGen())

cmds.showWindow(window)