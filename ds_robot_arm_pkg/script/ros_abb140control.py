#!/usr/bin/env python

import rospy
#from image_msgs.srv import sendimage
from cv_bridge import CvBridge
import cv2

import numpy as np
#import math
import time
#from ABB140ControlVrep.vrep import * as vrep
#from tsp_solver.greedy import solve_tsp

import sys 
import os
#from ABB140ControlVrep.ABB140_control import *
from ABB140ControlVrep.ABB140_control_3to2_C_ROS_I import *
#from ABB140ControlVrep.ABB140_control_3to2_C import *

from std_msgs.msg import Bool
from ud_msgs.msg import DrawMessagePkg

#rospy.set_param('ds_robot_arm_drawing', False)
#rospy.set_param('ds_robot_arm_EmergencyS', False) # should change to ros master later

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "ABB140ControlVrep/Images/smile.png") #ds_test/tes/UNICAMP_Crop/arrow/smile/Angle

def robot_drawing(v_pic2drawpath):
    print("Using Pic from following location:")
    print(v_pic2drawpath)
    rospy.loginfo("Draw function start")
    #rgb_img = cv2.imread(filename)
    #cv2.imshow("ROS Original Pic", rgb_img)
    # Drawing plane Height Constant - According to the VREP model
    Z_draw=0.1065 #Z_draw=0.1065
    factor, path, points, x, y = image_processing_optimization(img = v_pic2drawpath,factor = 1, size = 90) # Restriction -> factor*size < 350
    #factor, path, points, x, y = image_processing_optimization(img = u'ABB140ControlVrep/Images/UNICAMP_Crop.png', factor = 1, size = 100) # Restriction -> factor*size < 350

    # Create the ABB Rapid code
    script_RAPID_draw(path,u"example", u"P1", u"Bic", points, 100, 3)

    # Start Drawing
    counter = 0
    while rospy.get_param("/ds_robot_arm_EmergencyS"):
	if counter == 0:
		rospy.loginfo("ros_abb140control.py - robot arm movement pause!")
		counter = 200
	counter = counter - 1
	time.sleep(.005) # pause when ds_robot_arm_EmergencyS is true
    draw_VREP(factor, path, points, Z_draw, x, y) 

    # Wait until a key press
    #cv2.waitKey()
    cv2.destroyAllWindows()

def start_drawing(msg):
	if msg.startdraw:
		rospy.loginfo("Init. Drawing Process!")
		rospy.set_param('ds_robot_arm_drawing', True)
		pub.publish(True)
		#filename = msg.pic2drawpath
		# Start drawing Function
		robot_drawing(msg.pic2drawpath)
		rospy.set_param('ds_robot_arm_drawing', False)
		pub.publish(False)


if __name__ == "__main__":
	rospy.init_node("ds_robot_arm_control")
	rospy.loginfo("robot_arm_control node created")

	sub = rospy.Subscriber("/ds_start_drawing",DrawMessagePkg,start_drawing)
	#sub = rospy.Subscriber("/ds_start_drawing",Bool,start_drawing)

	pub = rospy.Publisher("/ds_robot_arm_drawing", Bool, queue_size=10) 

	rospy.spin()


