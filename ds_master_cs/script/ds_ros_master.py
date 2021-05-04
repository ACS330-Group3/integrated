#!/usr/bin/env python

import sys 
import os
import numpy as np
import rospy
import time

from std_msgs.msg import Bool
from std_msgs.msg import String
from ud_msgs.msg import CubeLifterMessagePkg
from ud_msgs.msg import PicInfoMessagePkg
from ud_msgs.srv import robotACSsrv
from ud_msgs.srv import dsCLsrv
from ud_msgs.srv import dsCLiftsrv
from ud_msgs.srv import dsCRotatesrv

from VisionControlVRep.ds_qc_vs_vrep import *
from cs_updateStatus import *

def udice_received(req):
	#if req.udiceReceived == True and req.ds_Cube_ID != '':
	if req.data != '':
		ds_Cube_ID = req.data # ds_Cube_ID = req.ds_Cube_ID
		rospy.loginfo("ds_ros_master.py - uDice id : {}".format(ds_Cube_ID))
		rospy.set_param('ds_C_ID', ds_Cube_ID)
		#rospy.set_param('ds_ud_Location', 'CubeLifter')
		#check cube location
		rospy.wait_for_service("/ds_CL_ser") # related code ds_cube_locator_ser.py not completed
		try:
			cubeLocationSP = rospy.ServiceProxy("/ds_CL_ser", dsCLsrv)
			response = cubeLocationSP(True)
			if str(response.cubeLocation) == 'CubeLifter':
				rospy.loginfo("ds_ros_master.py - udice at right location - {}(Should be CubeLifter) - response from ds_CL_ser". format(response.cubeLocation))
				pub1.publish(True) # ask to retrieve pic
			else:
				rospy.loginfo("ds_ros_master.py - udice at wrong location - {}(Should be CubeLifter) - response from ds_CL_ser". format(response.cubeLocation))
				pubUPE.publish(True) # publish that udice at wrong location
		except rospy.ServiceException as e:
			rospy.logwarn("service failed: " + str(e))	
	else:
		rospy.loginfo("ds_ros_master.py - udice not existed or ds_Cube_ID == None")

def udice_Pic_received(picinfo): # related code ds_pic_retrive not completed
	if picinfo.pic_retrieved == True and picinfo.ds_Cube_ID == str(rospy.get_param("/ds_C_ID")):
		rospy.loginfo("ds_ros_master.py - Pic ID matched with uDice ID!")
		if picinfo.ds_pic_name is not '':
			rospy.loginfo("ds_ros_master.py - Pic name : {}".format(picinfo.ds_pic_name))
			rospy.set_param('ds_PicG', picinfo.ds_pic_name)
			rospy.loginfo("ds_ros_master.py - Pic received and saved")
			cube_lifter() # lift up the cube
			#ros_RArmC_Ser(3) # test drawing function
		else:
			rospy.loginfo("ds_ros_master.py - Fail to retrieve pic name!")
	else:
		rospy.loginfo("ds_ros_master.py - Pic not received or Pic ID unmatched!")
	
def cube_lifter():
	if str(rospy.get_param("/ds_ud_Location")) == 'CubeLifter': # cube located below the cube rotater
		# cube rotator rotate to 1st position
		rospy.loginfo("ds_ros_master.py - Cube located at CubeLifter! CubeRotator to 1st position action init.")
		imgRequestPositionNum = 0
		rospy.wait_for_service("/ds_CRotate_ser")
		try:
			CRotate = rospy.ServiceProxy("/ds_CRotate_ser", dsCRotatesrv)
			response = CRotate(imgRequestPositionNum)	
			if response.CRotateSuccessed == True:
				rospy.loginfo("CRotate successed! - rotate to {} position!". format(imgRequestPositionNum))			# no need to run drawing cmd
			else:
				rospy.loginfo("CRotate not successed! - Cube rotator not rotate!")
		except rospy.ServiceException as e:
			rospy.logwarn("service failed: " + str(e))
		# cube lifted up
		rospy.loginfo("ds_ros_master.py - Cube located at CubeLifter! CubeLifter Action init.")
		rospy.wait_for_service("/ds_CLift_ser")
		try:
			CLift = rospy.ServiceProxy("/ds_CLift_ser", dsCLiftsrv)
			response = CLift('up')	
			rospy.loginfo("ds_ros_master.py - CLift down after gripping!")
			time.sleep(1) #pause for one sec
			response = CLift('down')
			rospy.set_param('ds_ud_Location', 'CubeRotator')
			if response.CLiftSuccessed == True:
				rospy.loginfo("CLift up successed! - Cube rotator action init.!")
				cube_rotator()
			else:
				rospy.loginfo("CLift up not successed! - Cube rotator action not init.!")

		except rospy.ServiceException as e:
			rospy.logwarn("service failed: " + str(e))

	elif str(rospy.get_param("/ds_ud_Location")) == 'CubeRotator': # cube located at the cube rotater
		# cube rotator release the cube
		rospy.loginfo("ds_ros_master.py - Cube located at CubeRotator! CubeRotator release action init.")
		imgRequestPositionNum = 7
		rospy.wait_for_service("/ds_CRotate_ser")
		try:
			CRotate = rospy.ServiceProxy("/ds_CRotate_ser", dsCRotatesrv)
			response = CRotate(imgRequestPositionNum)	
			if response.CRotateSuccessed == True:
				rospy.loginfo("CRotate successed! - cube released!". format(imgRequestPositionNum))			# no need to run drawing cmd
			else:
				rospy.loginfo("CRotate not successed! - Cube rotator not released the cube!")
		except rospy.ServiceException as e:
			rospy.logwarn("service failed: " + str(e))
		# cube lifted down
		rospy.loginfo("ds_ros_master.py - Cube located at CubeRotator! CubeLifter down Action init.")
		rospy.wait_for_service("/ds_CLift_ser")
		try:
			CLift = rospy.ServiceProxy("/ds_CLift_ser", dsCLiftsrv)
			response = CLift('up')	
			rospy.loginfo("ds_ros_master.py - CLift down after release gripping!")
			time.sleep(1) #pause for one sec
			response = CLift('down')
			rospy.set_param('ds_ud_Location', 'CubeLifter')	
			if response.CLiftSuccessed == True:
				rospy.loginfo("CLift down successed! - Cube ready to leave DS!")
				pubCR2L.publish(True) # tell omniplatform to retrieve the udice
				updateStatus(str(rospy.get_param("/ds_C_ID")),'Transporting to QC') #updateStatus(8,'Transporting to QC')
			else:
				rospy.loginfo("CLift down not successed! - Cube not ready to leave DS!")

		except rospy.ServiceException as e:
			rospy.logwarn("service failed: " + str(e))
	else:
		rospy.loginfo("ds_ros_master.py - Cube not located at CubeLifter!")

def cube_rotator():
	if str(rospy.get_param("/ds_ud_Location")) == 'CubeRotator':
		rospy.loginfo("ds_ros_master.py - Cube located at CubeRotator! CubeRotator Action init.")

		for imgRequestPositionNum in range(1,2+1): # included 1,2

			#if imgRequestPositionNum == 2:
				#rospy.set_param('ds_robot_arm_EmergencyS', True)
				#rospy.loginfo("ds_ros_master.py - Emergency activated!")
			#while rospy.get_param("/ds_robot_arm_EmergencyS"):
				#if counter == 0:
					#rospy.loginfo("ds_ros_master.py - Emergency activated! - Please unclock action with rostopic pub /ds_continue_button std_msgs/Bool data: true !!!")
					#counter = 600 # show info every 3 secs
				#counter = counter - 1
				#time.sleep(.005) # pause when ds_robot_arm_EmergencyS is true
# set parameter to emergency stop

			#imgRequestPositionNum = 1
			rospy.wait_for_service("/ds_CRotate_ser")
			try:
				CRotate = rospy.ServiceProxy("/ds_CRotate_ser", dsCRotatesrv)
				response = CRotate(imgRequestPositionNum)	
				if response.CRotateSuccessed == True:
					rospy.loginfo("CRotate successed! - rotate to {} position!". format(imgRequestPositionNum))			

					ros_RArmC_Ser(imgRequestPositionNum) # test drawing function
					# pause until ds_robot_arm_drawing is false
					time.sleep(3) # wait for 3 secs to let the robot arm ser react
					counter = 0
					while rospy.get_param("/ds_robot_arm_drawing"):
						if counter == 0:
							rospy.loginfo("ds_ros_master.py - cmd pause - robot arm drawing process not finish!")
							counter = 600 # show info every 3 secs
						counter = counter - 1
						time.sleep(.005) # pause when ds_robot_arm_EmergencyS is true
					vsQC(imgRequestPositionNum)
				else:
					rospy.loginfo("CRotate not successed! - Cube rotator not rotate!")
			except rospy.ServiceException as e:
				rospy.logwarn("service failed: " + str(e))

		cube_lifter() # CRotator release and lift down the cube
	else:
		rospy.loginfo("ds_ros_master.py - Cube not located at CubeRotator!")	

def ros_RArmC_Ser(ImageNum):
	rospy.wait_for_service("/robotACS")
	try:
		drawImageNum = rospy.ServiceProxy("/robotACS", robotACSsrv)
		response = drawImageNum(ImageNum)
		rospy.loginfo("Response from ros RArmC Service is : {}". format(response.imgRequestReceived))
		if sorted(response.imgRequestReceived) != sorted("Img Request Successful"):
			rospy.loginfo("Error received from ros_abb140control_ser.py : {}".format(response.imgRequestReceived))
	except rospy.ServiceException as e:
		rospy.logwarn("service failed: " + str(e))



if __name__ == "__main__":
	rospy.init_node("ds_ros_master")
	rospy.loginfo("ds_ros_master node created")

	# need tuning with String msg type
	sub1 = rospy.Subscriber("/ds_cube_sensed",String,udice_received)
	#sub1 = rospy.Subscriber("/ds_cube_sensed",CubeLifterMessagePkg,udice_received)

	pub1 = rospy.Publisher("/ds_pic_retrieve_ProcessStart", Bool, queue_size=10) # server need to connect to central system

	pubUPE = rospy.Publisher("/ds_udice_position_Err", Bool, queue_size=10) # publish that udice at wrong location - need to connect with omniplatform

	sub2 = rospy.Subscriber("/ds_pic_retrieved",PicInfoMessagePkg,udice_Pic_received)

	pubCR2L = rospy.Publisher("/ds_udice_Ready2Leave", Bool, queue_size=10) # publish that udice at wrong location - need to connect with omniplatform

	rospy.spin()
