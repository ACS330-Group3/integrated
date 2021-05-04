#!/usr/bin/env python

import sys 
import os
import numpy as np
import rospy

from std_msgs.msg import Bool
from ud_msgs.msg import PicInfoMessagePkg

from ud_msgs.srv import csSendImages
from cv_bridge import CvBridge
import cv2

dirname = os.path.dirname(__file__)
picfolder = os.path.join(dirname, "image_cs")

def pic_retrieve_ProcessStart(req):
	if req.data == True:
		rospy.loginfo("ds_pic_retrieve.py - pic retrieve request received")
		rospy.wait_for_service("/cs_image_service")
		try:
			pubimage = rospy.ServiceProxy("/cs_image_service", csSendImages)
			#rospy.set_param('ds_C_ID', 11) # need to delete after integration
			CubeID = str(rospy.get_param("/ds_C_ID"))
			response = pubimage(CubeID)
			IDPicName = str(response.picName)
			rospy.loginfo("IDPicName:{}". format(IDPicName))
			ImgList = []
			br = CvBridge()
			#image = br.imgmsg_to_cv2(response.im1, desired_encoding='passthrough')
			ImgList.append(br.imgmsg_to_cv2(response.im1, desired_encoding='passthrough'))
			ImgList.append(br.imgmsg_to_cv2(response.im2, desired_encoding='passthrough'))
			ImgList.append(br.imgmsg_to_cv2(response.im3, desired_encoding='passthrough'))
			ImgList.append(br.imgmsg_to_cv2(response.im4, desired_encoding='passthrough'))
			ImgList.append(br.imgmsg_to_cv2(response.im5, desired_encoding='passthrough'))
			ImgList.append(br.imgmsg_to_cv2(response.im6, desired_encoding='passthrough'))
			for PicNum in range(1,6+1): # included 1,2,3,4,5,6
				filename = CubeID+'_'+IDPicName+'_'+str(PicNum)+'.png'
				filepath = os.path.join(picfolder, filename)
				rospy.loginfo("Image Received - {}". format(filename))
				#rospy.loginfo(str(response.im1))

				cv2.imwrite(filepath, ImgList[PicNum-1])
				#cv2.imwrite(r'abc.jpg', image)
			pub1.publish(True,CubeID,IDPicName)
			
		except rospy.ServiceException as e:
			rospy.logwarn("service failed: " + str(e))

if __name__ == "__main__":
	rospy.init_node("ds_pic_retrieve_service")
	rospy.loginfo("ds_pic_retrieve_service node created")

	sub1 = rospy.Subscriber("/ds_pic_retrieve_ProcessStart", Bool, pic_retrieve_ProcessStart)

	pub1 = rospy.Publisher("/ds_pic_retrieved",PicInfoMessagePkg,queue_size=10)

	rospy.spin()
