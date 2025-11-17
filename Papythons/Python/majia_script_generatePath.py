import maya.cmds as cmds
from random import *

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

def animRandAtWorldCenter(master, attToNoise):
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

def main():
    for i in range(nbPaths):
        master = "master" + str(i+1)
        child = "placeHolder" + str(i+1)
        cmds.spaceLocator(n=child, p=[1, 0, 0])
        cmds.spaceLocator(n=master)
        cmds.parent(child, master)
        animRandAtWorldCenter(master, attToNoise)

main()