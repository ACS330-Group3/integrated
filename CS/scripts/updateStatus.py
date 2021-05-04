# -*- coding: utf-8 -*-
"""
Created on Sat Apr 10 11:39:00 2021

@author: georg
"""

#Imports necessary packages
import sshtunnel
import mysql.connector

def updateStatus(ID,status):
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
                
                #Stores the passed in Column and ID
                statusUpdate = status
                productID = ID
                
                #Construct Query String
                queryString = "UPDATE productDetails SET status = '{}' WHERE productID = {}".format(statusUpdate,productID)
                
                
                #Begin Query Process
                mycursor = db.cursor()
                #select image Column from Database Table
                mycursor.execute(queryString)
                db.commit()

                db.close()
                #returns a success if successful
    except mysql.connector.Error as err:
        print("Something went wrong: {}".format(err))
        return ('Fail')
    finally:
        if db:
            db.close()
            #returns a success if successful
            return ("Succesful Update")
        print('All Connections closed')
        return ("Succesful Update")
