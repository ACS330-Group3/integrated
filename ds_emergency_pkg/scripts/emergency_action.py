#!/usr/bin/env python

import rospy
from std_msgs.msg import Bool

#rospy.set_param('ds_robot_arm_EmergencyS', False)
#rospy.set_param('ds_robot_arm_Reset', False)

#emergency_button_pressed = False

def emergency_action(msg):
	if msg.data:
		rospy.loginfo("Emergency action start!")
		rospy.set_param('ds_robot_arm_EmergencyS', True)
		pub1.publish(True)

def ds_continue(msgr):
	if msgr.data:
		rospy.loginfo("Emergency action deactivated!")
		rospy.set_param('ds_robot_arm_EmergencyS', False)
		pub1.publish(False)

def emergency_reset(msgr):
	if msgr.data:
		rospy.loginfo("Reset button pressed!")
		rospy.set_param('ds_Reset', False)
		pub1.publish(False)

if __name__ == '__main__':

	rospy.init_node("ds_emergency_reaction_server")
	rospy.loginfo("emergency_reaction_server node created")

	sub1 = rospy.Subscriber("/ds_emergency_button",Bool,emergency_action)
	sub2 = rospy.Subscriber("/ds_light_sensor",Bool,emergency_action)

	sub3 = rospy.Subscriber("/ds_continue_button",Bool,ds_continue)
	sub4 = rospy.Subscriber("/ds_reset_button",Bool,emergency_reset)

	pub1 = rospy.Publisher("/emergency_stop", Bool, queue_size=10) # also use this topic for emergency alarm

	rospy.spin()
