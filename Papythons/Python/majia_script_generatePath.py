import maya.cmds as cmds
import maya.mel as mel
from random import *
from math import *

# User inputs

target = "target_pt"

animStart = 1
animEnd = 170
fps = 24

root = "root_anim"

nbPaths = 5

rNoiseFreq = 1

sNoiseFreq = 1
sNoiseMin = 1
sNoiseMax = 3

smoothCrv = 1.75
sampleCrv = 6.5

lateToTarget = 10

papythonGrp = "all_papython_grp"
papythonAnim = "papython_anim"
meshToGenerate = "papython:papython_grp"

LWing = "L_wing_msh"
RWing = "R_wing_msh"

velThreshold = .3
angleMin = -65
angleMax = 30
wingSpeed = 4

sMin = .2
sMax = .4







# Init
rNbFrames = int((animEnd - animStart) / fps * rNoiseFreq)
sNbFrames = int((animEnd - animStart) / fps * sNoiseFreq)
    # [action, "attribut", nb de frames à keyer, minimum du noise, maximum du noise]
attToNoise = [[cmds.rotate, "rotateX", rNbFrames, -180, 180],
              [cmds.rotate, "rotateY", rNbFrames, -180, 180],
              [cmds.rotate, "rotateZ", rNbFrames, -180, 180],
              [cmds.scale, "scaleX", sNbFrames, sNoiseMin, sNoiseMax]]
root = root + "_ctrl"




def animRandAtWorldCenter(master):
    # Animation
    for key in attToNoise:
        (action, attname, nbFrame, Nmin, Nmax) = key
        att = master + "." + attname
        # List aléatoire de frames ou poser des clefs entre le debut et la fin de l'anim
        frameL = [animStart, animEnd]
        for i in range(nbFrame):
            frame = randint(animStart, animEnd+1)
            frameL.append(frame)
        # Placement des clefs avec des valeurs au hasard
        for frame in frameL:
            x = uniform(Nmin, Nmax)
            cmds.currentTime(frame)
            action(x, x, x, master, a=True)
            cmds.setKeyframe(att)
    # Clean
    cmds.scale(x, 1, 1, master, a=True)
    toSmoothL = []
    for key in attToNoise:
        toSmoothL.append(master + "_" + key[1])
    cmds.filterCurve(*toSmoothL, cof=smoothCrv, f="butterworth", sr=sampleCrv)

def createMotionAtWorldCenter():
    # Créer le nombre d'animations choisi par l'utilisateur
    for i in range(nbPaths):
        # Générer les noms
        number = str(i+1)
        if(len(number) == 1):
            number = "0" + number
        master = "master" + number + "_ctrl"
        child = "placeHolder" + number + "_lct"
        # Créer les obj maya
        cmds.group(n=master, em=True, w=True)
        #cmds.spaceLocator(n=child, p=[1, 0, 0])
        cmds.spaceLocator(n=child)
        cmds.xform(child, ws=True, t=[1,0,0])
        cmds.parent(child, master)
        # Animation
        animRandAtWorldCenter(master)
    # Clean de la scène
    cmds.group(n=root, em=True, w=True)
    cmds.parent(cmds.ls('master*', type='transform'), root)







def listTargetPos(target):
    posListe = []
    for frame in range(animStart, animEnd+1):
        cmds.currentTime(frame)
        position = cmds.xform(target, q=True, t=True, ws=True)
        posListe.append(position)
    return posListe

def followTarget(follower, target, late):
    posListe = listTargetPos(target)
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





def velFromPos(posListe):
    velListe = []
    for i in range(len(posListe)-1):
        vel = [posListe[i+1][0] - posListe[i][0],
               posListe[i+1][1] - posListe[i][1],
               posListe[i+1][2] - posListe[i][2]]
        velListe.append(vel)
    velListe.append(velListe[len(posListe)-2])
    return velListe

def normalize(v):
    norm = sqrt(v[0]**2 + v[1]**2 + v[2]**2)
    if norm == 0:
        return [0, 0, 1]  # fallback si le vecteur est nul
    return [v[0]/norm, v[1]/norm, v[2]/norm]

def orientToVel(follower, posListe):
    velListe = velFromPos(posListe)
    
    for frame in range(animStart, animEnd+1):
        idx = frame - animStart
        cmds.currentTime(frame)
        
        vel = velListe[idx]
        dirVel = normalize(vel)
        
        # Calcul de la rotation en radians
        rotX = -atan2(dirVel[1], sqrt(dirVel[0]**2 + dirVel[2]**2))  # X = inclinaison
        rotY = atan2(dirVel[0], dirVel[2])  # angle entre l'axe X et la vel projetée dans XZ
        
        # Conversion en degrés
        rotX = degrees(rotX)
        rotY = degrees(rotY)
        rotZ = 0  # pas de rotation sur Z
        
        # Appliquer la rotation
        cmds.rotate(rotX, rotY, rotZ, follower, a=True)
        cmds.setKeyframe(follower, at="rotate")

    return velListe



def velNorm(coordonnees):
    velnorm = sqrt(coordonnees[0]**2 + coordonnees[1]**2 + coordonnees[2]**2)
    return velnorm

def AnimWingsToVel(velListe, wingMesh, isRight):
    # Si on anime l'aile droite, il faut inverser les angles de rotation de l'aile
    bottom = angleMin
    top =  angleMax
    if(isRight):
        bottom = -bottom
        top = -top
    # Cherche quand la vitesse est plus grande que le threshold d'anim
    frame = animStart
    while(frame < animEnd + 1):
        vel = velNorm(velListe[frame - animStart])
        if(vel < velThreshold):
            # Si la vitesse est trop petite on va checker la frame suivante
            frame += 1
        else:
            # Si la vitesse est assez grande, on anime l'aile tant que la vitesse reste assez grande
            isTop = True
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
                # On check si la nouvelle vitesse est toujours sous le threshold
                if(frame < animEnd + 1):
                    vel = velNorm(velListe[frame - animStart])
            # Quand la vel passe sous le threshold on remet une clef à 0
            cmds.currentTime(frame)
            cmds.rotate(0, 0, 0, wingMesh, a=True)
            cmds.setKeyframe(wingMesh, at="rotate")
            # Puis on va checker la frame suivante
            frame += 1


            







def prepMesh(mesh, nameRoot):
    # Scale aléatoire
    randS = uniform(sMin, sMax)
    cmds.scale(randS, randS, randS, mesh)
    # Tout mettre dans un groupe pour pas casser la hiérarchie
    cmds.group(n=nameRoot, em=True, w=True)
    cmds.parent(mesh, nameRoot)

def bakeToMesh():
    # Liste de tous les points animés
    targetList = cmds.ls('placeHolder*', type='transform')
    # Copier le modèle sur chaque point
    for i in range(len(targetList)):
        number = str(i+1)
        if(len(number) == 1):
            number = "0" + number
        nameMode = "papython" + number + "_grp"
        nameAnim = papythonAnim + number + "_ctrl"
        target = targetList[i]
        # Créer un nouvel examplaire du mesh à baker
        cmds.duplicate(meshToGenerate, n=nameMode)
        # Prep le nouveau mesh
        prepMesh(nameMode, nameAnim)
        # Translate : placer les mesh sur le même translate que les points
        posListe = followTarget(nameAnim, target, 0)
        # Rotate : orienter les mesh selon la vitesse
        velListe = orientToVel(nameAnim, posListe)
        # Anim les ailes en fonction de la vitesse
        tofind = nameMode + "|" + RWing #nameMode + "|**|" + RWing
        wingMesh = cmds.ls(tofind, r=True)
        AnimWingsToVel(velListe, wingMesh, False)
        tofind = nameMode + "|" + LWing
        wingMesh = cmds.ls(tofind, r=True)
        AnimWingsToVel(velListe, wingMesh, True)
    # Clean
    cmds.group(n=papythonGrp, em=True, w=True)
    cmds.parent(cmds.ls(papythonAnim + "*", type='transform'), papythonGrp)
        








def main():
    # Garder en mémoire l'était de l'autokey et le désactiver
    autokey = bool(mel.eval('autoKeyframe -q -state;'))
    print("AutoKey activé :", autokey)
    mel.eval("autoKeyframe -state 0;")
    
    # Création du bon nombre de points qui tournent autour du centre du monde
    createMotionAtWorldCenter()
    # Animation du centre de l'animation pour qu'il suive la target
    followTarget(root, target, lateToTarget)
    # Placer les modèles de papythons sur les points animés
    bakeToMesh()

    # Clean final
    cmds.parent(root, papythonGrp)
    cmds.hide(root)

    # Ré activer l'autokey s'il était activé au départ
    if(autokey):
        mel.eval("autoKeyframe -state 1;")


main()