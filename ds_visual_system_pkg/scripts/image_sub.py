#!/usr/bin/env python

import sys
import os
import rospy
import cv2
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "s_abc.png") 

def callback(data):
	br = CvBridge()
	rospy.loginfo('RECEIVING')
	img = br.imgmsg_to_cv2(data)
	cv2.imwrite(filename,img)
	cv2.waitKey(1)
	cv2.destroyAllWindows()

def receive_msg():
	rospy.init_node('Image_sub')
	rospy.Subscriber('image_topic_1', Image, callback)

if __name__ == "__main__":
	receive_msg()
	rospy.spin()
