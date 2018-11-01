#!/usr/bin/env python2
from __future__ import division

import sys
sys.path.append('/opt/freecad/lib') # path to your FreeCAD.so or FreeCAD.dll file
#sys.path.append('/usr/lib/freecad/lib') # path to your FreeCAD.so or FreeCAD.dll file
import FreeCAD

from ezFreeCAD import *

# from measurements [mm]
#top and bottom lips
lipOuterD = 365
lipInnerD = lipOuterD-2*(lipOuterD-340)
lipHeight = 15

# cylinder
totalCylinderHeight = 505
wallInnerD = lipInnerD + 8*2
wallOuterD = lipOuterD - 15*2
wallThickness = (wallOuterD - wallInnerD)/2

# floating plate
plateThickness = 3
windowSquare = 54
plateHeight = 390
plateDiameter = 300

# bottom lip adjust
lipAdjustHeight = 3.6
lipAdjustStartD = lipOuterD - 2*2.5
lipAdjustEndD = lipAdjustStartD - 2*lipAdjustHeight
botFlangeOuterD = lipAdjustEndD

# flanges
botFlangeThickness = 15
topFlangeThickness = 12
botFlangeStep = 0.75
stepStartD = botFlangeOuterD - 2*25
stepEndD = botFlangeOuterD - 2*26.25

# three top ports
topPortD = 48
topPortEdgeOffset = 35.9
topPortHeight = 13.75

# viewing port
bottomLipToEdge = 143
vPortBThickness = 42
vPortOuterD = 7.5 * 25.4
vPortCapThickness = 20
vportMinProtrusion = 10

evapDim = 56

bottomLip=extrude(circle(lipOuterD/2),0,0,lipHeight)
bottomLip=difference(bottomLip,extrude(circle(lipInnerD/2),0,0,lipHeight))

topLip = translate(bottomLip,0,0,totalCylinderHeight-lipHeight)

cylinderWall = extrude(circle(wallOuterD/2),0,0,totalCylinderHeight)
vPort = cylinder(vPortOuterD/2,wallOuterD/2+vportMinProtrusion)
vPort = rotate(vPort,-90,0,0)
vPort = translate(vPort,0,0,bottomLipToEdge+vPortOuterD/2+lipHeight)
cylinderWall = union(cylinderWall,vPort)
cylinderWall = difference(cylinderWall, extrude(circle(wallInnerD/2),0,0,totalCylinderHeight))
cylinderWall = difference(cylinderWall,translate(rotate(cylinder(vPortOuterD/2-wallThickness,lipOuterD/2+vportMinProtrusion),-90,0,0),0,0,bottomLipToEdge+vPortOuterD/2+lipHeight))

vPortCap = difference(cylinder(vPortOuterD/2,vPortCapThickness),cylinder(vPortOuterD/2-vPortBThickness,vPortCapThickness))
vPortCap = translate(rotate(vPortCap,-90,0,0),0,wallOuterD/2+vportMinProtrusion,bottomLipToEdge+vPortOuterD/2+lipHeight)

body = union(bottomLip,cylinderWall)
body = union(body, topLip)
body = difference(body,Part.makeCone(lipAdjustStartD/2,lipAdjustEndD/2,lipAdjustHeight))
#save2DXF(section(body,1),"edgeOfLip.dxf")
#save2DXF(section(body),"midSection.dxf")

topFlange = extrude(circle(lipOuterD/2),0,0,topFlangeThickness)
topFlange = translate(topFlange,0,0,totalCylinderHeight)

floatingPlate = circle(plateDiameter/2)
evapCutout = translate(rectangle(windowSquare,windowSquare),-windowSquare/2,-windowSquare/2,0)
evapCutout = rotate(evapCutout,0,0,45)
floatingPlate = difference(floatingPlate,evapCutout)
floatingPlate = extrude(floatingPlate,0,0,plateThickness)
floatingPlate = translate(floatingPlate,0,0,plateHeight+lipAdjustHeight+botFlangeStep)

bottomFlange = union(cylinder(botFlangeOuterD/2,botFlangeThickness),translate(cone(stepStartD/2,stepEndD/2,botFlangeStep),0,0,botFlangeThickness))
bottomFlange = translate(bottomFlange,0,0,-botFlangeThickness+lipAdjustHeight)

# this stuff helps visualize the evaporation
evapPlane = translate(rectangle(evapDim,evapDim),-evapDim/2,-evapDim/2,plateHeight+lipAdjustHeight+botFlangeStep+plateThickness)
evapPlane = rotate(evapPlane,0,0,45)
pointSourceZ = 80 #random guess
sourcePoint = Part.Vertex(0,0,pointSourceZ)
loftBits = evapPlane.Wires
loftBits.append(sourcePoint)
ballisticTrajectory = Part.makeLoft(loftBits,True).Solids[0]



# chamber above here
# wheels below here

# this is the assumed radius of the cutting tool (for corner ears&fillets)
toolRadius=1.5

# wheels stuff below here
shieldMaskWheelSpacing = 0.5
maskSampleWheelSpacing = 0.5
# delta between the end of the motor shafts and the edge of the universal mounting hubs
# negative means the shaft extends beyond the universal hub mount
# (-1.5 might be as negative you can go before the hub runs into the motor bar)
maskUniShaftDelta = 1 # this is so the sample wheel doesn't hit the mask motor bar
sampleUniShaftDelta = 0

# stepper motor
motor = STEP2Solid("input/zss_25_axial.step")
motorShaftLength=9.5
motorShaftD=3
motorWidth=25
mountHoleOffset = 2**(1/2)*21.5/2
mountingHoleD = 2.2

maskMotor = motor

#mask wheel
maskWheelD = 194
maskWheelThickness = 3
maskWheel = cylinder(maskWheelD/2,maskWheelThickness)

maskCutout = roundedRectangle(evapDim,evapDim,r=toolRadius,drillCorners=True)
maskCutout = extrude(maskCutout,0,0,maskWheelThickness)
# pocket for mask to sit in
maskPocketDepth = 0.6
maskPocketOffset = 1.5
maskPocketDim = evapDim + maskPocketOffset*2;
maskPocketA = roundedRectangle(maskPocketDim,maskPocketDim,r=toolRadius)
maskPocketB = translate(maskPocketA,-maskPocketOffset,-maskPocketOffset,maskWheelThickness)
maskPocket = extrude(maskPocketB,0,0,-maskPocketDepth)
maskCutout = union(maskCutout,maskPocket)

# chamfer the mask edges
chamferLength = 2
chamferBottomFace = rectangle(evapDim+chamferLength*2,evapDim+chamferLength*2)
chamferBottomFace = translate(chamferBottomFace,-chamferLength,-chamferLength,0)
chamferTopFace = rectangle(evapDim,evapDim)
chamferTopFace = translate(chamferTopFace,0,0,chamferLength)
loftBits = chamferBottomFace.Wires
loftBits.append(chamferTopFace.Wires[0])
chamferSolid = Part.makeLoft(loftBits,True).Solids[0]
maskCutout = union(maskCutout,chamferSolid)

# these are the offsets for the wheel windows relative to the center of the wheel
winDx = -92.5980
winDy = 0

# move the cutout into position
maskCutout = rotate(maskCutout,0,0,-45)
maskCutout = translate(maskCutout,winDx,winDy,0)# move the window into position on the wheel
# subtract the windows from the wheel
maskCutouts = circArray(maskCutout,4,0,0,0,0,0,1) # duplicate it
maskWheel = difference(maskWheel,maskCutouts)

# sample wheel
sampleWheelD = maskWheelD
sampleWheelThickness = 6
sampleWheel = cylinder(sampleWheelD/2,sampleWheelThickness)

sampleShelfHeight = 0.5
trayShelfHeight = 0.5
grabberHoleDepth = sampleWheelThickness/2
sampleWheel2D = loadDXF("sampleWheel2D.dxf")
trayCutoutStep = difference(extrude(sampleWheel2D["trayOuter"][0],0,0,trayShelfHeight),extrude(sampleWheel2D["trayOuterStep"][0],0,0,trayShelfHeight))
trayCutout = difference(extrude(sampleWheel2D["trayOuter"][0],0,0,sampleWheelThickness),trayCutoutStep)

sampleCutout = translate(extrude(sampleWheel2D["trayInner"][0],0,0,sampleWheelThickness-trayShelfHeight),0,0,trayShelfHeight)
sampleCutout = union(sampleCutout, extrude(sampleWheel2D["glassSeat"][0],0,0,sampleShelfHeight))

grabberHoles = [Part.Face(Part.Wire(edge)) for edge in sampleWheel2D["grabberHoles"]] # facify the edges from the DXF
grabberHoles = extrude(grabberHoles,0,0,grabberHoleDepth)
grabberHoles = translate(grabberHoles,0,0,sampleWheelThickness-grabberHoleDepth)

sampleTray = trayCutout
sampleTray = difference(trayCutout,sampleCutout)
sampleTray = difference(sampleTray,grabberHoles)
sampleTrays = circArray(sampleTray,4,0,0,0,0,0,1)

generatePrototype = True
if generatePrototype is True:
    # 3D print the sample tray for testing:
    solid2STL(sampleTray, "output/sampleTray.stl")

trayCutouts = circArray(trayCutout,4,0,0,0,0,0,1) # duplicate it
sampleWheel = difference(sampleWheel,trayCutouts)

# cutout motor shaft holes
shaftCutoutD = motorShaftD+0.2
shaftCutout = cylinder(shaftCutoutD/2,sampleWheelThickness)
maskWheel = difference(maskWheel,shaftCutout)
sampleWheel = difference(sampleWheel,shaftCutout)

# universal hub https://www.pololu.com/product/1996
m3ClearanceD=3.2
fourHolesOffset=6.35
uniShaftHoleD=3
uniD=17.5
uniThickness=5
hubMount=cylinder(m3ClearanceD/2,sampleWheelThickness)
hubMount=translate(hubMount,fourHolesOffset,0,0)
hubMounts=circArray(hubMount,4,0,0,0,0,0,1)

uniHub=cylinder(uniD/2,uniThickness)
uniHub=difference(uniHub,cylinder(uniShaftHoleD/2,uniThickness))
# drill out both wheels and the universal hub in one go!
[uniHub,maskWheel,sampleWheel]=difference([uniHub,maskWheel,sampleWheel],hubMounts)

#carouselSlice = section(maskWheel)
#save2DXF(maskWheel, "output/carouselSlice.dxf")

# motor bar
barWidth=motorWidth # the same as the motor diameter
barLength=220
barThickness=plateThickness

motorBar = rectangle(barWidth,barLength)
stepperBumpD = 14
stepperBumpCutoutD = stepperBumpD+0.4
stepperBumpCutout = translate(circle(stepperBumpCutoutD/2),barWidth/2,barLength/2,0)
motorBar = difference(motorBar,stepperBumpCutout)
motorBar = translate(motorBar,-barWidth/2,-barLength/2,0)

# motor mounting holes
motorMountHole = circle(mountingHoleD/2)
motorMountHole = translate(motorMountHole,mountHoleOffset,0,0)
motorMountHoles = circArray(motorMountHole,4,0,0,0,0,0,1,startAngle=45)
motorBar = difference(motorBar,motorMountHoles)
motorBar = extrude(motorBar,0,0,barThickness)

# blocks to hold up mask motor bar
blockWidth = 10
maskBlockHeight = shieldMaskWheelSpacing+maskWheelThickness+motorShaftLength-barThickness+maskUniShaftDelta
maskBlockLength = barWidth
maskBlock = rectangle(maskBlockLength,blockWidth)
maskBlock = extrude(maskBlock,0,0,maskBlockHeight)
maskBlockHoleA = translate(cylinder(m3ClearanceD/2,maskBlockHeight+barThickness+plateThickness),maskBlockLength/4,blockWidth/2,-plateThickness)
maskBlockHoleB = mirror(maskBlockHoleA,maskBlockLength/2,0,0,1,0,0)
blockAssembly = [maskBlock,maskBlockHoleA,maskBlockHoleB]

accessoryHoleDrills = translate([maskBlockHoleA,maskBlockHoleB],-maskBlockLength/2,barWidth/2,0)
motorBar = difference(motorBar,accessoryHoleDrills)

blockAssemblyA=translate(blockAssembly,-maskBlockLength/2,barLength/2-blockWidth,0)
blockAssemblyB=translate(blockAssembly,-maskBlockLength/2,-barLength/2,0)

# put the motor bar on top of the blocks
motorBar = translate(motorBar,0,0,maskBlockHeight)

maskBarAssembly = [motorBar] + blockAssemblyA + blockAssemblyB
# bar, blockA, drill1, drill2, blockB, drill3, drill4

# form the mask wheel assembly
# put the motor on the bar
maskMotor = mirror(maskMotor,0,0,0,0,0,1)
maskMotor = translate(maskMotor,0,0,maskBlockHeight+barThickness) 
maskAssembly=[maskMotor]+maskBarAssembly
# attach the universal hub onto the wheel
maskHub = translate(uniHub,0,0,maskWheelThickness)
# attach the hub and wheel to the motor shaft
wheelAssembly = translate([maskHub,maskWheel],0,0,shieldMaskWheelSpacing)
# attach the wheel and hub to the motor and motor bar
maskAssembly += wheelAssembly
# tack on the sample wheel and another universal hub for the ride
maskAssembly.append(sampleWheel)
maskAssembly.append(uniHub)
maskAssembly += sampleTrays
# objects order inside maskAssembly: motor,bar,blockA,drill1,drill2,blockB,drill3,drill4,universalHub,maskCarousel,sampleWheel,sampleHub,fourSampleTrays

#move the assembly into position
maskAssemblyXOffset = plateDiameter/2-maskWheelD/2
maskAssemblyYOffset = 0
maskAssembly = translate(maskAssembly,maskAssemblyXOffset,maskAssemblyYOffset,plateHeight+lipAdjustHeight+botFlangeStep+plateThickness)
maskMotor = maskAssembly[0]
maskWheel = maskAssembly[9]
maskHub = maskAssembly[8]

sampleWheel = maskAssembly[10]
sampleHub = maskAssembly[11]
sampleTrays = maskAssembly[-4:]

#solid2STEP(maskAssembly,"output/maskAssembly.step")

# drill the mask assembly mounting holes
thingsToDrillWith = [maskAssembly[3],maskAssembly[4],maskAssembly[6],maskAssembly[7]]
drilledThings=difference([maskAssembly[1],maskAssembly[2],maskAssembly[5],floatingPlate],thingsToDrillWith)
maskMotorBar=drilledThings[0]
maskBlockA=drilledThings[1]
maskBlockB=drilledThings[2]
floatingPlate=drilledThings[3]

# mirror over some stuff (across the x=0 plane) to create the sample wheel assembly
thingsToMirror=[maskMotorBar,maskBlockA,maskBlockB,sampleHub,maskMotor,sampleWheel] + sampleTrays + thingsToDrillWith
mirroredThings=mirror(thingsToMirror,0,0,0,1,0,0)

# pick out the drill objects
drills = mirroredThings[-4:]
del(mirroredThings[-4:]) # then throw them away

# drill the sample assembly mounting holes
floatingPlate = difference(floatingPlate,drills)

# rename the mirrored things so we can keep track of them
sampleMotorBar = mirroredThings[0]
sampleBlockA = mirroredThings[1]
sampleBlockB = mirroredThings[2]
sampleHub = mirroredThings[3]
sampleMotor = mirroredThings[4]
sampleWheel = mirroredThings[5]
sampleTrays = mirroredThings[-4:]

# the distance between the sheild and the bottom of the sample wheel
sampleWheelheight = maskWheelThickness + maskSampleWheelSpacing + shieldMaskWheelSpacing

# the difference in height between the two motor bars
sampleMotorBarOffset = sampleWheelThickness + sampleUniShaftDelta - maskUniShaftDelta + maskSampleWheelSpacing

# move the sample motor and bar into place
[sampleMotor,sampleMotorBar] = translate([sampleMotor,sampleMotorBar],0,0,sampleMotorBarOffset)

# move the sample wheel into place
[sampleWheel,sampleTrayA,sampleTrayB,sampleTrayC,sampleTrayD] = translate([sampleWheel]+sampleTrays,0,0,sampleWheelheight)

# move the sample hub into place
sampleHub = translate(sampleHub,0,0,sampleWheelheight+sampleWheelThickness)

# grow the sample motor bar blocks
sampleBlockA=union(sampleBlockA,translate(sampleBlockA,0,0,sampleMotorBarOffset))
sampleBlockB=union(sampleBlockB,translate(sampleBlockB,0,0,sampleMotorBarOffset))

b40_chamber=[topFlange,body,vPortCap,floatingPlate,bottomFlange,ballisticTrajectory,evapPlane]
wheelsAssembly=[maskMotorBar,maskBlockA,maskBlockB,maskHub,floatingPlate,maskMotor,maskWheel,sampleMotorBar,sampleBlockA,sampleBlockB,sampleHub,sampleMotor,sampleWheel,sampleTrayA,sampleTrayB,sampleTrayC,sampleTrayD]

toMakeAssembly=[maskMotorBar,maskBlockA,maskBlockB,maskWheel,sampleMotorBar,sampleBlockA,sampleBlockB,sampleWheel,sampleTrayA,sampleTrayB,sampleTrayC,sampleTrayD]

everything = [maskMotorBar,maskBlockA,maskBlockB,maskHub,topFlange,body,vPortCap,floatingPlate,bottomFlange,maskMotor,evapPlane,maskWheel,ballisticTrajectory,sampleMotorBar,sampleBlockA,sampleBlockB,sampleHub,sampleMotor,sampleWheel,sampleTrayA,sampleTrayB,sampleTrayC,sampleTrayD]

solid2STEP(wheelsAssembly, "output/wheelsAssembly.step")
solid2STEP(b40_chamber, "output/b40_chamber.step")
solid2STEP(everything, "output/everything.step")
solid2STEP(toMakeAssembly, "output/toMakeAssembly.step")

solid2STEP(maskMotorBar, "output/parts_to_make/maskMotorBar.step")
solid2STEP(maskBlockA, "output/parts_to_make/maskBlockA.step")
solid2STEP(maskBlockB, "output/parts_to_make/maskBlockB.step")
solid2STEP(maskWheel, "output/parts_to_make/maskWheel.step")

solid2STEP(sampleMotorBar, "output/parts_to_make/sampleMotorBar.step")
solid2STEP(sampleBlockA, "output/parts_to_make/sampleBlockA.step")
solid2STEP(sampleBlockB, "output/parts_to_make/sampleBlockB.step")
solid2STEP(sampleWheel, "output/parts_to_make/sampleWheel.step")
solid2STEP(sampleTrayA, "output/parts_to_make/sampleTrayA.step")
solid2STEP(sampleTrayB, "output/parts_to_make/sampleTrayB.step")
solid2STEP(sampleTrayC, "output/parts_to_make/sampleTrayC.step")
solid2STEP(sampleTrayD, "output/parts_to_make/sampleTrayD.step")

print "break"
