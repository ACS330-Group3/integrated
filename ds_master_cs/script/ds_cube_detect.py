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
    print("Message from ds_cube_detect.py : import Vrep Success!")

def Start(IP='127.0.0.1', PORT=19995):# Local IP and API address (19995)
	# This fucntion starts the communication with the simulator
	vrep.simxFinish(-1) # Finish all the connections
	clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19995 
	while clientID == -1:
		clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19995 # Keep connecting if connection not established
		print("ds_cube_detect.py - Fail to connect VRep, reconnecting!")
		#rospy.set_param('ds_vrep_connected', False)
		time.sleep(.005)
	print("ds_cube_detect.py - Connection stablished with VRep")
	#rospy.set_param('ds_vrep_connected', True)
	return clientID

def cubeSenseFun():
	# start VREP connection
	clientID = Start()
	# retrieve revolute joint handles 
	errorCode, sensor_handle = vrep.simxGetObjectHandle(clientID,'Force_sensor_dsC',vrep.simx_opmode_oneshot_wait)

	errorCode,detectionState,detectedPoint,detectedObjectHandle,detectedSurfaceNormalVector = vrep.simxReadProximitySensor(clientID,sensor_handle,vrep.simx_opmode_streaming)
	
	print("errorCode:{}". format(errorCode))
	print("detectionState:{}". format(detectionState))
	print("detectedPoint:{}". format(detectedPoint))
	print("detectedObjectHandle:{}". format(detectedObjectHandle))
	print("detectedSurfaceNormalVector:{}". format(detectedSurfaceNormalVector))

if __name__ == "__main__":

cubeSenseFun()
