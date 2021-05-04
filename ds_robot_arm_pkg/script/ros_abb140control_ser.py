#!/usr/bin/env python

import sys 
import os
import numpy as np
import rospy
import cv2
from cv_bridge import CvBridge

#from ABB140ControlVrep.ABB140_control_3to2_C import *

from ud_msgs.srv import robotACSsrv
from ud_msgs.msg import DrawMessagePkg
#from std_msgs.msg import Bool
#from std_msgs.msg import String

#rospy.set_param('ds_robot_arm_drawing', False)

orifiledir = os.path.dirname(__file__)
picfolderpackage = os.path.abspath(os.path.join(orifiledir, '..', '..', 'ds_master_cs'))
picfolder = os.path.join(picfolderpackage, "script/image_cs")
pic2draw = picfolder

#rospy.set_param('ds_C_ID', '107')
#rospy.set_param('ds_PicG', '450')
#ds_C_ID = '007'
#ds_PicG = '450'

def SerHandle(req):
	if not rospy.get_param("/ds_robot_arm_drawing"):
		if req.imgRequestNum > 0 and req.imgRequestNum < 7:
			rospy.loginfo("robotACS service request received: {}".format(req.imgRequestNum))
			PicName = str(rospy.get_param("/ds_C_ID"))+"_"+str(rospy.get_param("/ds_PicG"))+"_"+str(req.imgRequestNum)+".png"
			pic2draw = os.path.join(picfolder, PicName)
			rospy.loginfo("Using Pic from following location: {}".format(pic2draw))
			#rgb_img = cv2.imread(pic2draw)
			#cv2.imshow(u"Original Pic", rgb_img)
			#cv2.waitKey(0)
			#cv2.destroyAllWindows()
			pub.publish(True,pic2draw)
			return "Img Request Successful"
		return "Img Request Unsuccessful : Request Pic name not in range"
	return "Img Request Unsuccessful : Robot Arm currently Drawing"

if __name__ == "__main__":
	rospy.init_node("ds_robot_arm_control_server")
	rospy.loginfo("robot_arm_control_server node created")

	pub = rospy.Publisher("/ds_start_drawing", DrawMessagePkg, queue_size=10) 

	service = rospy.Service("/robotACS", robotACSsrv, SerHandle)

	rospy.loginfo("robot_arm_control_server service READY")
	rospy.loginfo("Pic dir folder: {}".format(picfolder))
	rospy.spin()
