#!/usr/bin/env python

import rospy
from ud_msgs.srv import sendimage
from cv_bridge import CvBridge
import cv2
import os

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "abc.png") 

if __name__ == '__main__':
	rospy.init_node('Publish_client')
	rospy.wait_for_service("/pubimage")
	
	try:
		pubimage = rospy.ServiceProxy("/pubimage", sendimage)
		response = pubimage('YES')
		rospy.loginfo("Image Received:")
		rospy.loginfo(str(response.im))
		br = CvBridge()
		image = br.imgmsg_to_cv2(response.im, desired_encoding='passthrough')
		#image = br.imgmsg_to_cv2(response.im)
		cv2.imwrite(filename, image)
		#cv2.imwrite(r'abc.jpg', image)
		
	except rospy.ServiceException as e:
		rospy.logwarn("service failed: " + str(e))
