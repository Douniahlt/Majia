import maya.cmds as cmds
from random import *

# User inputs

animStart = 1
animEnd = 75
fps = 24

nbPaths = 5

rNoiseFreq = 5

sNoiseFreq = 1
sNoiseMin = 5
sNoiseMax = 7.5

smoothCrv = 10
sampleCrv = 10

lateToTarget = 5

# Init
rNbFrames = int((animEnd - animStart) / fps * rNoiseFreq)
sNbFrames = int((animEnd - animStart) / fps * sNoiseFreq)
# [action, "attribut", nb de frames à keyer, minimum du noise, maximum du noise]
attToNoise = [[cmds.rotate, "rotateX", rNbFrames, -180, 180],
              [cmds.rotate, "rotateY", rNbFrames, -180, 180],
              [cmds.rotate, "rotateZ", rNbFrames, -180, 180],
              [cmds.scale, "scaleX", sNbFrames, sNoiseMin, sNoiseMax]]

def randomFrameList(frameL, animStart, animEnd, nbFrame):
    for i in range(nbFrame):
        frame = randint(animStart, animEnd+1)
        frameL.append(frame)
    return frameL

def animRandAtWorldCenter(master):
    # animation
    for key in attToNoise:
        (action, attname, nbFrame, Nmin, Nmax) = key
        att = master + "." + attname
        # Création de la liste
        frameL = [animStart, animEnd]
        for i in range(nbFrame):
            frame = randint(animStart, animEnd+1)
            frameL.append(frame)
        # Placement des clefs
        for frame in frameL:
            x = uniform(Nmin, Nmax)
            cmds.currentTime(frame)
            action(x, x, x, master, a=True)
            cmds.setKeyframe(att)
    # clean
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
        child = "placeHolder" + number + "_lctr"
        # Créer les obj maya
        cmds.spaceLocator(n=child, p=[1, 0, 0])
        cmds.spaceLocator(n=master)
        cmds.parent(child, master)
        # Animation
        animRandAtWorldCenter(master)
    # Clean de la scène
    cmds.select(cmds.ls('master*'))
    cmds.group(n="root_grp", w=True)



def listTargetPos(target):
    posListe = []
    for frame in range(animStart, animEnd+1):
        cmds.currentTime(frame)
        position = cmds.xform(target, q=True, t=True, ws=True)
        posListe.append(position)
    return posListe

def followTarget(target):
    posListe = listTargetPos(target)
    root = "root_grp"
    for frame in range(animStart, animEnd+1):
        cmds.currentTime(frame)
        idx = frame - animStart
        cmds.move(*posListe[idx], root)
        cmds.setKeyframe(root, at="translate")




# Faire des groupes pour les master à la place des locateur
# Scale le locateur place holder à 1 meme en x
# Traiter les curves dans follow target pour avoir moins de clef
# Mettre en place le retard
# Mettre en place la vitesse et l'accélération du root pour suivre la target

"""
target = "target_pt"
posListe = []
for frame in range(animStart, animEnd+1):
    cmds.currentTime(frame)
    position = cmds.xform(target, q=True, t=True, ws=True)
    posListe.append(position)
print(posListe)

cmds.curve(p=posListe)
"""





target = "target_pt"

def main():
    createMotionAtWorldCenter()
    followTarget(target)


main()





