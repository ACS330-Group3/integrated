#!/usr/bin/env python

import sys
import os
import rospy
import cv2
from std_msgs.msg import String
from sensor_msgs.msg import Image
from cv_bridge import CvBridge, CvBridgeError

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "smile.png") 

def publish_msg():
	pub = rospy.Publisher('image_topic_1',Image, queue_size=10)
	rospy.init_node('Image_pub')
	rate = rospy.Rate(1)
	image = cv2.imread(filename)
	br = CvBridge()
	rospy.loginfo('PUBLISHING')
	image1 = br.cv2_to_imgmsg(image)
	pub.publish(image1)
	rate.sleep()

if __name__ == "__main__":
	publish_msg()
	rospy.spin()


