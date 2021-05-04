#!/usr/bin/env python

import sys 
import os
import numpy as np
import rospy
import cv2
from cv_bridge import CvBridge

from ud_msgs.srv import dsCLsrv

def SerHandle(req):
	if req.CLRequested == True:
		rospy.loginfo("CL service request received")
		cubeLocation = 'CubeLifter'
		rospy.loginfo("CL is : {}".format(cubeLocation))
		rospy.set_param('ds_ud_Location', cubeLocation)
	return cubeLocation

if __name__ == "__main__":
	rospy.init_node("ds_cube_locator_server")
	rospy.loginfo("ds_cube_locator_server node created")

	service = rospy.Service("/ds_CL_ser", dsCLsrv, SerHandle)

	rospy.loginfo("ds_cube_locator_server service READY")

	rospy.spin()
