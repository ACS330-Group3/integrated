u"""
MIT License

Copyright (c) 2020 Camilo A. Caceres

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
"""

from __future__ import division
from __future__ import absolute_import
import cv2
import numpy as np
import math
import time

import rospy
import time

try:
    from ABB140ControlVrep import vrep  # run with rosnode 
except ImportError:
    import vrep     # run with python directly
else:
    print("Message from ABB140_control_3to2_C_ROS_I.py : import Vrep Success!")
"""
    try:
        import vrep
    except ImportError:
	print("import Vrep Error!")
    else:
	print("Running : import vrep")
else:
    print("Running : from ABB140ControlVrep import vrep")
"""
from tsp_solver.greedy import solve_tsp

import imutils
izip = zip
#from itertools import izip
from io import open

#rospy.set_param('ds_vrep_connected', False)

################################################################################
#########################           Functions            #######################
################################################################################

def distance(x1, y1, x2, y2):
    u'''
    This fucntion calculates the  Euclidian distance between 2 points

    Args:
        x1 (float): X value of the first point
        y1 (float): Y value of the first point
        x2 (float): X value of the second point
        y2 (float): Y value of the secons point

    Returns:
        dist (float): Euclidian distance between point 1 and 2
    '''
    dist = math.sqrt((x1 - x2)**2 + (y1 - y2)**2)
    return dist

# 
def Start(IP=u'127.0.0.1', PORT=19996):# Local IP and API address (19999)
    u'''
    This fucntion starts the communication with the simulator
    Important: 
        First click play on the simulator then run his program
        Verify the vrep requirements of the remote API library: 
            "remoteApi.dll" (Windows)   
            "remoteApi.dylib" (Mac) 
            "remoteApi.so" (Linux)
            In Windows:
            C:\Program Files\CoppeliaRobotics\CoppeliaSimEdu\programming\remoteApiBindings\lib\lib
        Put the required requirement in the same directory of this app
    
    By default it should run with the default VREP configuration
    '''
    vrep.simxFinish(-1) # Finish all the connections
    clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19999 
    while clientID == -1:
        clientID=vrep.simxStart(IP, PORT, True, True, 5000, 5) # Start a new connection in the VREP default port 19999 # Keep connecting if connection not established
	rospy.loginfo(u'ABB140_control_3to2_C_ROS_I.py - Fail to connect VRep, reconnecting!')
	rospy.set_param('ds_vrep_connected', False)
	time.sleep(.005)
    rospy.loginfo(u'ABB140_control_3to2_C_ROS_I.py - Connection stablished with VRep')
    rospy.set_param('ds_vrep_connected', True)
    return clientID


def locate_pen(x, y, z, target, plane, clientID):
    u'''
    VREP locate pen function on the position x, y, z on the space
    taking as reference targer and plane
    '''
    #print (u"x: {} y:{} z:{}".format(x,y,z))
    counter = 0
    while rospy.get_param("/ds_robot_arm_EmergencyS"):
	if counter == 0:
		rospy.loginfo("ABB140_control_3to2_C_ROS_I.py - robot arm movement pause!")
		counter = 200
	counter = counter - 1
	time.sleep(.005) # pause when ds_robot_arm_EmergencyS is true
    vrep.simxSetObjectPosition(clientID, target, plane, [x-0.045,y-0.045,z+0.05], vrep.simx_opmode_oneshot_wait)
    #vrep.simxSetObjectPosition(clientID, target, plane, [x-0.0455,y-0.0495,z+0.05], vrep.simx_opmode_oneshot_wait)
    #vrep.simxSetObjectPosition(clientID, target, plane, [x,y,z], vrep.simx_opmode_oneshot_wait)

# Image processing (get edges) and path optimization 
def image_processing_optimization(img = u'Images/UNICAMP1_Crop.png', factor = 1, size = 350):
    u'''
    This function process an image obtaining the edges ussing canny.
    It also optimizes the path that will be draw using an ecternal library (tsp-solver).
    Args:
        img (str): 
            The desired image source location
        factor (int): 
            Reduction or scaling factor (1 is normal, less for reduce (ex 0.5), more increases (1.5))
        size (int): 
            The size of the draw (in the given simulation 200 is little and 350 maximum) - but depends of the draw size also

    Returns:
        factor(int): 
            Reduction or scaling factor (1 is normal, less for reduce, more increases)
        points (list): 
            List of the draw points lists of [x, y] positions
        path (list) : 
            Optimized sequence of path for the points list
        
    Example:
        image_processing_optimization('Images/LAIR.jpg', 1, 200)
    '''
    print (u"Program running")
    rgb_img = cv2.imread(img)
    cv2.imshow(u"Original Pic", rgb_img)
    #rgb_img = (255-rgb_img) # invert between black & white
    #rgb_img = imutils.rotate_bound(rgb_img, 45) 
    #cv2.imshow(u"Rotated (Correct)", rgb_img)
    x, y, _ = rgb_img.shape
    max_value = max(x, y)

    desired_size = [size, size]
    desired =   [desired_size[0]*(y/max_value), 
                desired_size[1]*(x/max_value), 
                3]

    scale = [desired[0]/y,
            desired[1]/x]

    #rgb_img = cv2.resize(rgb_img, None,fx=scale[0], fy=scale[1], interpolation = cv2.INTER_CUBIC)

    rgb_img = cv2.resize(rgb_img, (int(desired[0]),int(desired[1])), interpolation = cv2.INTER_CUBIC)

    gray_img = cv2.cvtColor(rgb_img, cv2.COLOR_BGR2GRAY)

    edges = cv2.Canny(gray_img, 0, 255, apertureSize = 3)
    #edges = cv2.Canny(gray_img, 0, 255, apertureSize = 3)
    cv2.imshow(u'Image', edges)
    print (u"Image Processed")

    new_x, new_y, _ = rgb_img.shape
    edges = edges.tolist()

    point_x=[]
    point_y=[]

    for row in xrange(1, new_y):
        for column in xrange(1, new_x):
            if edges[column][row] == 255:
                point_x.append(row)
                point_y.append(column)

    points = list(izip(point_x, point_y))
    r  = [[0 for x in xrange(len(point_x))] for y in xrange(len(point_x))]

    print (unicode(len(point_x))+u" Points Obtained")

    for p1 in xrange(1,len(point_x)):   
        for p2 in xrange(1,len(point_x)):
            x1, y1= points[p1]
            x2, y2= points[p2]
            r[p1][p2]=distance(x1,y1,x2,y2)

    print (u"Distances calculated")        

            
    #TSP - library
    print (u"Solving TSP")
    path = solve_tsp(r)
    print (u"TSP Done")

    np_points = np.array(points)
    np_points = np_points*factor
    points = np_points.tolist()

    return factor, path, points, new_x, new_y

def draw_VREP(factor, path, points, Z_draw, x, y):
    u'''
    This function draws on VREP the specified draw

    Args:
        factor(int): 
            Reduction or scaling factor (1 is normal, less for reduce, more increases)
        points (list): 
            List of the draw points lists of [x, y] positions
        path (list) : 
            Optimized sequence of path for the points list
        Z_draw (float):
            Drawing plane Height Constant - According to the VREP model
    '''
    # Start VREP connection
    clientID= Start()

    # Identify the VREP environment objects
    _, plane = vrep.simxGetObjectHandle(clientID, u'DummyCubeDrawPoint', vrep.simx_opmode_oneshot_wait) # Reference point on the drawing plane
    #_, plane = vrep.simxGetObjectHandle(clientID, u'Dummy', vrep.simx_opmode_oneshot_wait) # DummyCube/DSCube/Cuboid/DummyCubeDrawPoint
    _, target = vrep.simxGetObjectHandle(clientID, u'IRB140_target', vrep.simx_opmode_oneshot_wait) # End effector joint Reference

    #print (u"plane ID: {}".format(plane))
    #print (u"target ID: {}".format(target))

    print (u"Drawing Optimizated image")
    #locate_pen(-0.071, 0, Z_draw+0.2+0.0501, target, plane, clientID)
    locate_pen(0, 0, Z_draw+0.2, target, plane, clientID)
    cv2.waitKey(2)

    img_result = np.zeros((x*factor, y*factor, 3), np.uint8)
    for each in xrange(1,(len(path))-1):
        x1, y1 = points[path[each]]
        x2, y2 = points[path[each+1]]
        if distance(x1, y1, x2, y2) <= 2:
            locate_pen(y1/1000, x1/1000, Z_draw, target, plane, clientID)
            time.sleep(0.01)
            # Draw the progress on an external canvas 
            cv2.line(img_result, 
                    tuple(points[path[each]]), 
                    tuple(points[path[each+1]]), 
                    (255, 0, 0), 
                    1)
            cv2.imshow(u'Optimized', img_result)
            cv2.waitKey(1)
            locate_pen(y2/1000, x2/1000, Z_draw, target, plane, clientID)
            time.sleep(0.01)
            cv2.waitKey(1)
        else:
            time.sleep(0.01)
            locate_pen(y1/1000, x1/1000, Z_draw+0.001, target, plane, clientID)
            time.sleep(0.01)
            locate_pen(y2/1000, x2/1000, Z_draw+0.001, target, plane, clientID)
            time.sleep(0.05)

    # Go to the initial position
    locate_pen(0, 0, Z_draw+0.2, target, plane, clientID) 
    print (u"Draw finished")

def script_RAPID_draw(path,module_name, reference_point_name, tool_name, points, vel=5, factor=1):
    u'''
    This function creates an ABB RAPID language program to draw the given path
    This doesnt work with VREP (CoppeliaSim)
    This is only to get the code and put it into the real ABB robot ABB 140
    Be careful because this script is adjusted to MY robot axis settings, calibration, tools and configurations
    USE IT CAREFULLY!!!!!!!!

    Args:
        module_name (str): Name of the program (how it will be saved)
        reference_point_name (str):  Name of the reference point in the ABB robot settings
        tool_name (str): Name of the tool in the ABB robot settings
        points (list): Path list
        vel (int): speed of the robot  (BE CAREFUL!!!!! start with a low number and the adjust)
        factor (int): factor to size of the draw 
    '''

    array_x=[]
    array_y=[]
    array_z=[]

    for point in xrange(0,len(points)-1):
        x1=points[path[point]][0]/2
        y1=points[path[point]][1]/2
        x2=points[path[point+1]][0]/2
        y2=points[path[point+1]][1]/2
        
        if distance(x1,y1,x2,y2)<= 1*factor:
            array_x.append(unicode(x1))
            array_y.append(unicode(y1))
            array_z.append(unicode(-15))
            
            array_x.append(unicode(x2))
            array_y.append(unicode(y2))
            array_z.append(unicode(-15))            
            
        else:
            array_x.append(unicode(x1))            
            array_y.append(unicode(y1))
            array_z.append(unicode(10))
            
            array_x.append(unicode(x2))
            array_y.append(unicode(y2))
            array_z.append(unicode(10))            

    try:
        file  = open(module_name+u".prg", u"r+")        
    except (IOError):
    #except (FileNotFoundError): # Use this for Python3 
        file  = open(module_name+u".prg", u"w")
        file  = open(module_name+u".prg", u"r+")        

    open(module_name+u".prg", u'w').close()

    #HEADER
    file.write(u"%%%\n  VERSION:1\n  LANGUAGE:ENGLISH\n%%%\n")
    file.write(u"\nMODULE "+module_name+u"\n")

    #CONSTANTS FOR MY ROBOT CONFIGURATION/ CALIBRATION
    file.write(u"\n! UPDATE reference point")
    ## Reference Point
    ## file.write("\nCONST robtarget P1:=[[572.06,42.23,447.88],[0.355512,-0.378941,0.762498,-0.385504],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];")
    file.write(u"\nCONST robtarget P1:=[[639.4,-119.9,378.9],[0.13334, -0.23621, 0.96143, -0.04554],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];")
    file.write(u"\n! UPDATE tool point")
    file.write(u"\nPERS tooldata "+tool_name+u":=[TRUE,[[0.500839,-0.574904,226.276],[1,0,0,0]],[0.25,[85,0,65],[1,0,0,0],0.01,0.01,0.01]];")


##    file.write("\nCONST num number_data:="+str(len(array_x))+";")
    file.write(u"\nVAR num array_draw_x{"+unicode(len(array_x))+u"}:= ["+ (u', '.join(array_x))+u"];")
    file.write(u"\nVAR num array_draw_y{"+unicode(len(array_y))+u"}:= ["+ (u', '.join(array_y))+u"];")
    file.write(u"\nVAR num array_draw_z{"+unicode(len(array_z))+u"}:= ["+ (u', '.join(array_z))+u"];")
    
    file.write(u"\n\tPROC main()")
    file.write(u"\n\t\tMoveAbsJ [[45,0,0,0,90,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]"+r'\NoEOffs,v100,z50,Bic;')
#file.write(u"\n\t\tMoveAbsJ [[45,0,0,0,90,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]"+ur"\NoEOffs,v100,z50,Bic;")
    file.write(u"\n\t\tMoveJ Offs("+reference_point_name+u',0,0,100),v100'+u",fine,"+tool_name+u";")
   
    file.write(u"\n\t\tFOR i FROM 1 TO Dim(array_draw_x, 1) DO")
    file.write(u"\n\t\t\tMoveL Offs ("+reference_point_name+u",array_draw_x{i},array_draw_y{i},array_draw_z{i}), v"+unicode(vel)+u",z1,Bic;")
    file.write(u"\n\t\tENDFOR")


    file.write(u"\n\t\tMoveL Offs"+u" ("+unicode(reference_point_name)+u",0,0,100),v"+unicode(vel)+u",z10,"+tool_name+u";")

    file.write(u'\n\t\tWaitTime 2;')
    file.write(u"\n\tENDPROC")
    file.write(u"\nENDMODULE")
    file.close()

################################################################################



################################################################################
########################              Main               #######################
################################################################################
if __name__ == u"__main__":
    # Drawing plane Height Constant - According to the VREP model
    Z_draw=0.1065 

    # Define image and process it
    # Bigger size better results, but it takes longer to process the TSP optimization
    # Lower size can lead to errors, but takes shortest time to process
    factor, path, points, x, y = image_processing_optimization(img = u'Images/UNICAMP_Crop.png', factor = 1, size = 100) # Restriction -> factor*size < 350

    # Create the ABB Rapid code
    script_RAPID_draw(path,u"example", u"P1", u"Bic", points, 100, 3)

    # Start Drawing
    draw_VREP(factor, path, points, Z_draw, x, y) 

    # Wait until a key press
    cv2.waitKey()
################################################################################
