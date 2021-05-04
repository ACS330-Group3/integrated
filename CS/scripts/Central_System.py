#!/usr/bin/env python

import rospy
import retrieveInfo
import updateStatus

from cs_msgs.srv import (Location,LocationResponse)

def handleLocation(req):
    dbAccessed = retrieveInfo.retrieveCol(req.ID, 'status')
    rospy.loginfo('Attempting to handleLocation, Recieved ID = {}, Accessed Status: {}'.format(req.ID,dbAccessed))
    
    if dbAccessed == 'Waiting for Pick Up':
        output = 1
        dummyHold = updateStatus.updateStatus(req.ID, 'Transporting to DS')
    elif dbAccessed == 'Arrived at the Drawing Station' or dbAccessed == 'Arrived at the Quality Control' or dbAccessed == 'Arrived at the Packing Station':
        output = 5
        dummyHold = retrieveInfo.retrieveCol(req.ID, 'status')
    elif dbAccessed == 'Transporting to QC':
        output = 2
        dummyHold = retrieveInfo.retrieveCol(req.ID, 'status')
    elif dbAccessed == 'Transporting to Packing':
        output = 3
        dummyHold = retrieveInfo.retrieveCol(req.ID, 'status')
    else:
        output = 5
        dummyHold = 'Waiting at Station'
    rospy.loginfo('Result {}'.format(dummyHold))
    return LocationResponse(output)

def main():
    rospy.init_node('CS_Node')
    loc = rospy.Service('Location', Location, handleLocation)
    print('Read to recieve Request')
    rospy.spin()

if __name__ == '__main__':
   main()
