import maya.cmds as cmds
import maya.mel as mel
from random import *
from math import *


############################################################################################################################################
############################################################################################################################################


# USER INPUTS

projectName = "papython"    # Les noms de groupes et controllers dépendront de ce nom
                            # Il sert aussi à identifier si le projet existe déjà et qu'il faut le remplacer ou s'il faut juste le créer

target = "target_pt"  # Nom du point que les mesh doivent suivrent

meshToGenerate = "papython:papython_grp"  # Nom du mesh sur lequel faire tourner la génération

animWings = True  # Choisit s'il y a des ailes à animer ou non

LWing = "L_wing_msh"  # Nom des ailes pour l'animation
RWing = "R_wing_msh"

animStart = 1
animEnd = 170
fps = 24

nbPaths = 5  # Nombre de mesh à animer


# Animation des place holders

rNoiseFreq = 1  # Fréquence du noise sur la rotation des place holders autour de la cible

sNoiseFreq = 1  # Fréquence du noise sur l'éloignement puis rapprochement des place holders à la cible
sNoiseMin = 1  # Rapprochement maximal
sNoiseMax = 3  # Eloignement maximal

smoothCrv = 1.75  # Niveau de smooth sur les courbes d'animation noisées (30 = pas smoothée, 0 = très smoothée)
sampleCrv = 6.5  # Niveau de simplification de la courbe, ie supprimer les clefs

lateToTarget = 10  # Nombre de frames de retard de l'animation du la courbe


# Détails de l'animation des mesh

velThreshold = .15  # Vitesse à partir de laquelle les ailes sont animées
wingSpeed = 4  # Nombre de frames entre les deux positions d'animation des ailes
angleMin = -65  # Angle pour la position extrêmale basse des ailes
angleMax = 50  # Position extrêmale haute

sMin = .2  # Scaling minimal du mesh
sMax = .4  # Scaling maximal


############################################################################################################################################
############################################################################################################################################


# INIT NAMES

lctr = "_lctr"
ctrl = "_ctrl"
grp = "_grp"
GRP = "_GRP"

mainGn = "GENERATOR_" + projectName.upper() + GRP

phPref = projectName + "_placeHolder"
animPhPref = projectName + "_anim_" + phPref
rootPh = projectName + "_root_" + phPref + ctrl

geoMshPref = "geo_" + projectName
animMshPref = "anim_" + projectName


# INIT UTILITAIRE

# Nombres de keys qu'il faudra poser pour les aléatoires en fonction de ce qu'a choisi l'utilisateur
rNbFrames = int((animEnd - animStart) / fps * rNoiseFreq)  # Pour la rotation
sNbFrames = int((animEnd - animStart) / fps * sNoiseFreq)  # Pour le scaling

# Listes des attributs sur lesquels il faut mettre des keys aléatoires avec les paramètres qui servent à faire tourner la fonction AnimRandAtWorldCenter
    # [action, "attribut", nb de frames à keyer, minimum du noise, maximum du noise]
attToNoise = [[cmds.rotate, "rotateX", rNbFrames, -180, 180],
              [cmds.rotate, "rotateY", rNbFrames, -180, 180],
              [cmds.rotate, "rotateZ", rNbFrames, -180, 180],
              [cmds.scale, "scaleX", sNbFrames, sNoiseMin, sNoiseMax]]


# FONCTIONS UTILITAIRES

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


############################################################################################################################################
############################################################################################################################################


# Si le projet existe déjà, le supprimer pour le recréer
def ResetProject():
    allTransfL = cmds.ls(type="transform")  # Liste de tous les groupes dans la scène

    if(mainGn in allTransfL):
        cmds.delete(mainGn)

    return None


############################################################################################################################################
############################################################################################################################################


# Anime un controller tourant et s'approchant aléatoirement autour du centre du monde
def AnimRandAtWorldCenter(controller):

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
def CreateMotionAtWorldCenter():

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
        AnimRandAtWorldCenter(parent)

    # Clean de la scène = tout grouper dans le root
    cmds.group(n=rootPh, em=True, w=True)
    cmds.parent(cmds.ls(animPhPref + "*", type="transform"), rootPh)

    return None


############################################################################################################################################
############################################################################################################################################


# Crée la liste des positions d'un obj à toutes les frames entre animStart et animEnd
def ListTargetPos(target):

    posListe = []
    for frame in range(animStart, animEnd+1):
        cmds.currentTime(frame)
        position = cmds.xform(target, q=True, t=True, ws=True)
        posListe.append(position)

    return posListe


# Place le root des mini rigs sur la traget en le retardant si nécessaire et pose des clefs
def FollowTarget(follower, target, late):

    posListe = ListTargetPos(target)

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


# Déduit, de la liste des positions, la liste des vitesses à toutes les frames
def VelFromPos(posListe):
    velListe = []

    # Tourne sur toutes les frames sauf la dernière pour éviter l'out of range
    for i in range(len(posListe)-1):
        # v = p(n+1) - p(n)
        vel = [posListe[i+1][0] - posListe[i][0],
               posListe[i+1][1] - posListe[i][1],
               posListe[i+1][2] - posListe[i][2]]
        velListe.append(vel)
    # Prend la vitesse de l'avant dernière frame pour la dernière frame aussi pour avoir une vitesse à chaque frame
    velListe.append(velListe[len(posListe)-2])

    return velListe


# Rotate un mesh "follower" pour qu'il s'oriente selon sa vitesse
def OrientToVel(follower, posListe):
    # Crée la liste des vitesses
    velListe = VelFromPos(posListe)
    
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
def AnimWingsToVel(velListe, wingMesh, isRight):

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
def PrepMesh(mesh, nameRoot):

    # Scale aléatoire
    randS = uniform(sMin, sMax)
    cmds.scale(randS, randS, randS, mesh)

    # Tout mettre dans un groupe pour pas casser la hiérarchie
    cmds.group(n=nameRoot, em=True, w=True)
    cmds.parent(mesh, nameRoot)

    return None


# Crée un mesh pour chaque place holder et bake l'animation des place holders sur un controller parent du mesh
def BakeToMesh(hasWings):

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
        PrepMesh(nameMode, nameAnim)

        # Translate : placer les mesh sur le même translate que les place holders
        posListe = FollowTarget(nameAnim, target, 0)

        # Rotate : orienter les mesh selon la vitesse
        velListe = OrientToVel(nameAnim, posListe)

        if(hasWings):  # Seulement si l'utilisateur veut animer les ailes
            # Anim les ailes en fonction de la vitesse
            # Aile droite
            tofind = nameMode + "|" + RWing # Trouver le bon mesh de l'aile
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToVel(velListe, wingMesh, False)
            # Aile gauche
            tofind = nameMode + "|" + LWing
            wingMesh = cmds.ls(tofind, r=True)
            AnimWingsToVel(velListe, wingMesh, True)

    # Clean = tout mettre dans un groupe principal
    cmds.group(n=mainGn, em=True, w=True)
    cmds.parent(cmds.ls(animMshPref + "*", type='transform'), mainGn)
        
    return None


############################################################################################################################################
############################################################################################################################################


def main():

    # Garder en mémoire l'était de l'autokey et le désactiver
    autokey = bool(mel.eval('autoKeyframe -q -state;'))
    mel.eval("autoKeyframe -state 0;")
    
    # Update ou création = si le projet existe déjà, le supprimer pour le recréer
    ResetProject()

    # Création du bon nombre de points qui tournent autour du centre du monde
    CreateMotionAtWorldCenter()

    # Animation du centre de l'animation pour qu'il suive la target avec un retard
    FollowTarget(rootPh, target, lateToTarget)

    # Placer les modèles de papythons sur les points animés
    BakeToMesh(animWings)

    # Clean final
    cmds.parent(rootPh, mainGn) # Mettre le rig des place holder dans le groupe principal du projet
    cmds.hide(rootPh) # et le cacher

    # Ré activer l'autokey s'il était activé au départ
    if(autokey):
        mel.eval("autoKeyframe -state 1;")

    return None


# EXECUTION PRINCIPALE
main()