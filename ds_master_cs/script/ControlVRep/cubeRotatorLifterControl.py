#!/usr/bin/env python

import numpy as np
import math
import time

import rospy
import time

try:
    from ControlVRep import vrep  # run with rosnode 
except ImportError:
    import vrep     # run with python directly
else:
    rospy.loginfo("Message from cubeRotatorLifterControl.py : import Vrep Success!")

def Start(IP='127.0.0.1', PORT=19998):# Local IP and API address (19999)
	# This fucntion starts the communication with the simulator
	vrep.simxFinish(-1) # Finish all the connections
	clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19999 
	while clientID == -1:
		clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19999 # Keep connecting if connection not established
		rospy.loginfo("cubeRotatorLifterControl.py - Fail to connect VRep, reconnecting!")
		#rospy.set_param('ds_vrep_connected', False)
		time.sleep(.005)
	rospy.loginfo("cubeRotatorLifterControl.py - Connection stablished with VRep")
	#rospy.set_param('ds_vrep_connected', True)
	return clientID

def cubeRotatorLifterControlFun(angleBase, angleHolder, liftDirection):
	# start VREP connection
	#clientID = Start()
	# retrieve revolute joint handles 
	#errorCode, angleBaseHandler = vrep.simxGetObjectHandle(clientID,'Revolute_joint_dsCRB',vrep.simx_opmode_oneshot_wait)
	#errorCode, angleHolderHandler = vrep.simxGetObjectHandle(clientID,'Revolute_joint_dsCRH',vrep.simx_opmode_oneshot_wait)
	#errorCode, liftHandler = vrep.simxGetObjectHandle(clientID,'Prismatic_joint_dsCLB',vrep.simx_opmode_oneshot_wait)

	# run control cmd when function run
	if angleBase != None:
		# start VREP connection
		clientID = Start(PORT=19997)
		# retrieve revolute joint handles 
		errorCode, angleBaseHandler = vrep.simxGetObjectHandle(clientID,'Revolute_joint_dsCRB',vrep.simx_opmode_oneshot_wait)	
	
		print("angleBase is : {}". format(angleBase))
		returnCode = vrep.simxSetJointTargetPosition(clientID,angleBaseHandler,int(angleBase)*math.pi/180,vrep.simx_opmode_oneshot)
		#returnCode = vrep.simxSetJointTargetVelocity(clientID, angleBaseHandler, 1, vrep.simx_opmode_oneshot)
		print("angleBase function finished and return code is : {}". format(returnCode))

	# prebuilt function
	if angleHolder != None:

		# start VREP connection
		clientID = Start(PORT=19997)
		# retrieve revolute joint handles 
		errorCode, angleHolderHandler = vrep.simxGetObjectHandle(clientID,'Revolute_joint_dsCRH',vrep.simx_opmode_oneshot_wait)	

		print("angleHolder is : {}". format(angleHolder))
		returnCode = vrep.simxSetJointTargetPosition(clientID,angleHolderHandler,int(angleHolder)*math.pi/180,vrep.simx_opmode_oneshot)
		#returnCode = vrep.simxSetJointTargetVelocity(clientID, angleBaseHandler, 1, vrep.simx_opmode_oneshot)
		print("angleHolder function finished and return code is : {}". format(returnCode))

	if liftDirection != None:

		# start VREP connection
		clientID = Start(PORT=19998)
		# retrieve revolute joint handles 
		errorCode, liftHandler = vrep.simxGetObjectHandle(clientID,'Prismatic_joint_dsCLB',vrep.simx_opmode_oneshot_wait)

		print("liftDirection is : {}". format(liftDirection))
		if liftDirection == 'up':
			returnCode = vrep.simxSetJointTargetPosition(clientID,liftHandler,-0.03,vrep.simx_opmode_oneshot)
			print("angleHolder function finished and return code is : {}". format(returnCode))
		elif liftDirection == 'down':
			returnCode = vrep.simxSetJointTargetPosition(clientID,liftHandler,-0.3,vrep.simx_opmode_oneshot)
			print("angleHolder function finished and return code is : {}". format(returnCode))
		else:
			print("non-exit cmd for liftDirection!")

if __name__ == "__main__":
	# without using ROS node
	cubeRotatorLifterControlFun(-45,None,None)
	time.sleep(1)
	#cubeRotatorLifterControlFun(135,0,0)
	cubeRotatorLifterControlFun(None,None,'up')
	time.sleep(1)
	cubeRotatorLifterControlFun(None,None,'down')
	time.sleep(1)
	cubeRotatorLifterControlFun(135,None,None)
