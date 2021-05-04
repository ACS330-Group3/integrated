# -*- coding: utf-8 -*-
"""
Created on Sat Apr 10 07:02:29 2021
@author: georg
"""
#Imports necessary packages
import sshtunnel
import mysql.connector
import requests
import os

dirname = os.path.dirname(__file__)
savedfolderName = "cs_image"
picfolder = os.path.join(dirname, savedfolderName)

#Defines the function to call outside of the system
def retrieveImage(Id):
    #Establishes secure tunnel connection config settings
    sshtunnel.SSH_TIMEOUT = 5.0
    sshtunnel.TUNNEL_TIMEOUT = 5.0
    
    #Connects with database through SSH tunnel hosted on public Linux Setup
    try:
        with sshtunnel.SSHTunnelForwarder(
            ('ssh.pythonanywhere.com'),
            ssh_username='jgbroz', ssh_password='Sly!25321',
            remote_bind_address=('jgbroz.mysql.pythonanywhere-services.com', 3306)
        ) as tunnel:
            db = mysql.connector.connect(
                user='jgbroz', password='Acs3302021',
                host='127.0.0.1', port=tunnel.local_bind_port,
                database='jgbroz$CentralSystem',
            )
            
            #Change Path when integrating
            savePath = picfolder
	#savePath = 'D:/ACS330 CS Code/Central System/CS/CS Logic/Retrieved Images'
            
            #Saves the passed in Id
            productID = Id
            for x in range(1,7):
                #Begin Query Process
                mycursor = db.cursor()
                #select image Column from Database Table
                query = "SELECT img{} FROM productDetails WHERE productID = {}".format(x,productID) 
                mycursor.execute(query)
                
                #Store the first result in a variable
                row = mycursor.fetchone()
                splitRow = row[0].split(".")
                print(splitRow[0])
                print(splitRow[1])
                fileName = "{}_{}_{}.{}".format(productID,"750",x,splitRow[1])
		#fileName = "{}_{}_{}.{}".format(productID,splitRow[0],x,splitRow[1])
                
                #Join File paths to one another when saving image
                completePath = os.path.join(savePath, fileName)
                #Join Image name to expected url to access it
                setUrl = 'http://jgbroz.pythonanywhere.com/uploads/'+ row[0]
                
                #print (setUrl) Prints the full URL (Testing)
                #Downlaods image using Requests tree
                r = requests.get(setUrl, allow_redirects=True)
                #Opens a new file to save the data to.
                open(completePath, 'wb').write(r.content)
            #Closes the database 
            db.close()
            #returns a success if successful
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))
        return ('Fail')
    finally:
        if db:
            db.close()
            #returns a success if successful
            return ('Success')
        print('All Connections closed')
        return ('Success')

if __name__ == "__main__":
	retrieveImage(1)
