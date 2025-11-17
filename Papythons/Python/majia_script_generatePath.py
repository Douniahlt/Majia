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
# [action, "attribut", minimum du noise, maximum du noise]
attToNoise = [[cmds.rotate, "rotateX", rNbFrames, -180, 180],
              [cmds.rotate, "rotateY", rNbFrames, -180, 180],
              [cmds.rotate, "rotateZ", rNbFrames, -180, 180],
              [cmds.scale, "scaleX", sNbFrames, sNoiseMin, sNoiseMax]]

"""
cmds.spaceLocator(n="placeHolder", p=[1, 0, 0])
cmds.spaceLocator(n="master")
cmds.parent("placeHolder", "master")
"""

def brouillon01():
    nbFrames = (animEnd - animStart) / fps * rNoiseFreq
    nbFrames = int(nbFrames)
    frameL = [animStart, animEnd]
    for i in range(nbFrames):
        frame = randint(animStart, animEnd+1)
        frameL.append(frame)

    if frameL[nbFrames] != animEnd:
        frameL.append(animEnd)
        nbFrames += 2
    else:
        nbFrames += 1
    print(frameL, nbFrames) 

    for frame in frameL:
        cmds.currentTime(frame)
        rx = uniform(-180, 180)
        ry = uniform(-180, 180)
        rz = uniform(-180, 180)
        cmds.rotate(rx, ry, rz, "master", a=True)
        cmds.setKeyframe("master.rotateX")
        cmds.setKeyframe("master.rotateY")
        cmds.setKeyframe("master.rotateZ")

def brouillon02():
    rNbFrames = (animEnd - animStart) / fps * rNoiseFreq
    rNbFrames = int(rNbFrames)
    sNbFrames = (animEnd - animStart) / fps * sNoiseFreq
    sNbFrames = int(sNbFrames)

    # [action, "attribut", minimum du noise, maximum du noise]
    attToNoise = [[cmds.rotate, "rotateX", -180, 180], [cmds.rotate, "rotateY", -180, 180], [cmds.rotate, "rotateZ", -180, 180], [cmds.scale, "scaleX", .3, 10]]

    for key in attToNoise:
        (action, attname, Nmin, Nmax) = key
        att = "master" + "." + attname
        # Création de la liste
        frameL = [animStart, animEnd]
        frameL = randomFrameList(frameL, animStart, animEnd, rNbFrames)
        print("%%%%%%%%%%%%%%%%%%%%%%%%%%%")
        print("For", att, " : ", frameL)
        # Placement des clefs
        for frame in frameL:
            x = uniform(Nmin, Nmax)
            print(x)
            cmds.currentTime(frame)
            action(x, x, x, "master", a=True)
            cmds.setKeyframe(att)
    cmds.scale(x, 1, 1, "master", a=True)
    cmds.filterCurve('master_rotateX', 'master_rotateY', 'master_rotateZ', 'master_scaleX', cof=smoothCrv, f="butterworth", sr=sampleCrv)

def randomFrameList(frameL, animStart, animEnd, nbFrames):
    for i in range(nbFrames):
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
        frameL = randomFrameList(frameL, animStart, animEnd, nbFrame)
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