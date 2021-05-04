#!/usr/bin/env python

import rospy
#from image_msgs.srv import sendimage
from cv_bridge import CvBridge
import cv2

import numpy as np
#import math
#import time
#from ABB140ControlVrep.vrep import * as vrep
#from tsp_solver.greedy import solve_tsp

import sys 
import os
#from ABB140ControlVrep.ABB140_control import *
from ABB140ControlVrep.ABB140_control_3to2_C import *

from std_msgs.msg import Bool

rospy.set_param('ds_robot_arm_drawing', False)

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "ABB140ControlVrep/Images/Angle.png") #ds_test/tes/UNICAMP_Crop/arrow/smile/Angle

def robot_drawing():
    print("Using Pic from following location:")
    print(filename)
    print("Draw function start")
    #rgb_img = cv2.imread(filename)
    #cv2.imshow("ROS Original Pic", rgb_img)
    # Drawing plane Height Constant - According to the VREP model
    Z_draw=0.1065 #Z_draw=0.1065
    factor, path, points, x, y = image_processing_optimization(img = filename,factor = 1, size = 100) # Restriction -> factor*size < 350
    #factor, path, points, x, y = image_processing_optimization(img = u'ABB140ControlVrep/Images/UNICAMP_Crop.png', factor = 1, size = 100) # Restriction -> factor*size < 350

    # Create the ABB Rapid code
    script_RAPID_draw(path,u"example", u"P1", u"Bic", points, 100, 3)

    # Start Drawing
    draw_VREP(factor, path, points, Z_draw, x, y) 

    # Wait until a key press
    cv2.waitKey()
    cv2.destroyAllWindows()

def start_drawing(msg):
	if msg.data:
		rospy.loginfo("Init. Drawing Process!")
		rospy.set_param('ds_robot_arm_drawing', True)
		pub.publish(True)
		# Start drawing Function
		robot_drawing()
		rospy.set_param('ds_robot_arm_drawing', False)
		pub.publish(False)


if __name__ == "__main__":
	rospy.init_node("robot_arm_control")
	rospy.loginfo("robot_arm_control node created")

	sub = rospy.Subscriber("/ds_start_drawing",Bool,start_drawing)

	pub = rospy.Publisher("/ds_robot_arm_drawing", Bool, queue_size=10) 

	rospy.spin()


