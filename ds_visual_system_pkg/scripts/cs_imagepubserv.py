#!/usr/bin/env python

import rospy
from ud_msgs.srv import csSendImages
from cv_bridge import CvBridge
import cv2
import os
from glob import glob

from cs_downloadImage import *

dirname = os.path.dirname(__file__)
savedfolderName = "cs_image"
picfolder = os.path.join(dirname, savedfolderName)
img_all_path = os.path.join(picfolder, "*.png")

def imghandle(req):
	if req.requestID != '':
		requestID = str(req.requestID)
		retrieveImage(int(requestID))
		#time.sleep(10)
		img_addrs = glob(img_all_path)
		print(img_addrs)
		for i in range(len(img_addrs)):
			temp_glob_path = img_addrs[i]
			temp_glob_imgFileName = (temp_glob_path.split(savedfolderName+"/"))[1]
			#print("temp_glob_imgFileName : {}". format(temp_glob_imgFileName))
			temp_glob_imgFileID = (temp_glob_imgFileName.split("_"))[0]
			temp_glob_imgFileName = (temp_glob_imgFileName.split("_"))[1]
			#print("temp_glob_path : {}". format(temp_glob_imgFileName))
			if temp_glob_imgFileID == requestID:
				#print("-----------")
				IDPicName = temp_glob_imgFileName
				#print("IDPicName is {}". format(IDPicName))
		#IDPicName = '450'
		ImgList = []
		for PicNum in range(1,6+1): # included 1,2,3,4,5,6
			filename = requestID+'_'+IDPicName+'_'+str(PicNum)+'.png'
			filepath = os.path.join(picfolder, filename)
			image = cv2.imread(filepath)
			br = CvBridge()
			rospy.loginfo("Image of {} is sent!". format(filename))
			ImgList.append(br.cv2_to_imgmsg(image, encoding='passthrough'))
			#image1 = br.cv2_to_imgmsg(image, encoding='passthrough')
		#image1 = br.cv2_to_imgmsg(image)
		return IDPicName,ImgList[0],ImgList[1],ImgList[2],ImgList[3],ImgList[4],ImgList[5]
		
if __name__ == "__main__":
	rospy.init_node("cs_Img_Publish_Server")
	rospy.loginfo("CS_Img_Publish_Server node created")
	service = rospy.Service("/cs_image_service", csSendImages, imghandle)
	rospy.loginfo("CS_Img_Publish_Server server started")
	rospy.spin()
