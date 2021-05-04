#!/usr/bin/env python

import numpy as np
import math
import time

import rospy
import time

import cv2

try:
    from VisionControlVRep import vrep  # run with rosnode 
except ImportError:
    import vrep     # run with python directly
else:
    rospy.loginfo("Message from ds_qc_vs_vrep.py : import Vrep Success!")

import os

dirname = os.path.dirname(__file__)
savedfolderName = "ds_img_qc"
picfolder = os.path.join(dirname, savedfolderName)

def Start(IP='127.0.0.1', PORT=19994):# Local IP and API address (19999)
	# This fucntion starts the communication with the simulator
	vrep.simxFinish(-1) # Finish all the connections
	clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19999 
	while clientID == -1:
		clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19999 # Keep connecting if connection not established
		rospy.loginfo("ds_qc_vs_vrep.py - Fail to connect VRep, reconnecting!")
		#rospy.set_param('ds_vrep_connected', False)
		time.sleep(.005)
	rospy.loginfo("ds_qc_vs_vrep.py - Connection stablished with VRep")
	#rospy.set_param('ds_vrep_connected', True)
	return clientID

def vsQC(QCPicOrder):
	# start VREP connection
	clientID = Start(PORT=19994)
	# retrieve vision handles
	res, vision_sensor_qc = vrep.simxGetObjectHandle(clientID, 'Vision_sensor_qc', vrep.simx_opmode_oneshot_wait)
	returnCode,resolution,image = vrep.simxGetVisionSensorImage(clientID,vision_sensor_qc,0, vrep.simx_opmode_streaming)
	
	while (vrep.simxGetConnectionId(clientID) != -1):
		err,resolution,image = vrep.simxGetVisionSensorImage(clientID,vision_sensor_qc,0, vrep.simx_opmode_buffer)
		if err == vrep.simx_return_ok:
			print "image OK!!!"
			img = np.array(image,dtype=np.uint8)
			img.resize([resolution[1],resolution[0],3])
			print "saving img!"
			#fileName = 'vsQC.jpg'
			fileName = "vsQC_{}.{}".format(QCPicOrder,"jpg")
			completePath = os.path.join(picfolder, fileName)
			cv2.imwrite(completePath, img)
			break
			#cv2.imshow('image',img)
			#if cv2.waitKey(1) & 0xFF == ord('q'):
				#break
		elif err == vrep.simx_return_novalue_flag:
			print "no image yet"
			pass
		else:
			print err
if __name__ == "__main__":
	vsQC(1)
	time.sleep(1)
	vsQC(2)
