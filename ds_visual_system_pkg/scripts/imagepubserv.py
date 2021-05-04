#!/usr/bin/env python

import rospy
from ud_msgs.srv import sendimage
from cv_bridge import CvBridge
import cv2
import os

#from cv_bridge.boost.cv_bridge_boost import getCvType

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "smile.png") 

def handle(req):
	if req.request == "YES":
		image = cv2.imread(filename)
		br = CvBridge()
		rospy.loginfo('DONEG')
		image1 = br.cv2_to_imgmsg(image, encoding='passthrough')
		#image1 = br.cv2_to_imgmsg(image)
		return image1
		
if __name__ == "__main__":
	rospy.init_node("Publish_Server")
	rospy.loginfo("SERVER NODE CREATED")
	service = rospy.Service("/pubimage", sendimage, handle)
	rospy.loginfo("SERVER STARTED")
	rospy.spin()
