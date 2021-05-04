#!/usr/bin/env python

import sys 
import os
import numpy as np
import rospy

from ud_msgs.srv import dsCLiftsrv

from ControlVRep.cubeRotatorLifterControl import *
# import rotate function

import time

def CLiftSerHandle(req):
	if str(req.CLiftDirection) == 'up':
		rospy.loginfo("CLift service request received : up")
		# lift function for VRep - check parameter with /ds_robot_arm_EmergencyS is false
		rospy.loginfo("CLift service provided : up")

		counter = 0
		while rospy.get_param("/ds_robot_arm_EmergencyS"):
			if counter == 0:
				rospy.loginfo("ds_cube_rotator.py - lifter movement pause!")
				counter = 200
			counter = counter - 1
			time.sleep(.005) # pause when ds_robot_arm_EmergencyS is true
		cubeRotatorLifterControlFun(None,None,'up')
		time.sleep(1) #pause 1 secs

		#cubeLocation = 'CubeRotator'
		#rospy.loginfo("CL is : {}".format(cubeLocation))
		#rospy.set_param('ds_ud_Location', cubeLocation)
		return True
	elif str(req.CLiftDirection) == 'down':
		rospy.loginfo("CLift service request received : down")
		# lift function for VRep - check parameter with /ds_robot_arm_EmergencyS is false
		rospy.loginfo("CLift service provided : down")

		counter = 0
		while rospy.get_param("/ds_robot_arm_EmergencyS"):
			if counter == 0:
				rospy.loginfo("ds_cube_rotator.py - lifter movement pause!")
				counter = 200
			counter = counter - 1
			time.sleep(.005) # pause when ds_robot_arm_EmergencyS is true
		cubeRotatorLifterControlFun(None,None,'down')
		time.sleep(1) #pause 1 secs

		#cubeLocation = 'CubeLifter'
		#rospy.loginfo("CL is : {}".format(cubeLocation))
		#rospy.set_param('ds_ud_Location', cubeLocation)
		return True
	return False

if __name__ == "__main__":
	rospy.init_node("ds_cube_lifter_server")
	rospy.loginfo("ds_cube_lifter_server node created")

	service = rospy.Service("/ds_CLift_ser", dsCLiftsrv, CLiftSerHandle)

	rospy.loginfo("ds_cube_lifter_server service READY")

	rospy.spin()
