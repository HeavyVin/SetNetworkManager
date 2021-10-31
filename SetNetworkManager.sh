#!/bin/bash

#Check and exit if user is not using elivated privalages
if [ "$EUID" -ne 0 ]
  then echo "This script needs to be run as root. Please use sudo or su to correct this."
  exit
fi

#Save the value of managed in the NetworkManager config file
ManagedState=$(grep "managed=" /etc/NetworkManager/NetworkManager.conf)

#Check that managed is not already equal to true
if [ $ManagedState = managed=false ]
	then
		echo "NetworkManager.conf was not set to managed"
    #Use sed to find and replace false to true
		sed -i s/managed=false/managed=true/ /etc/NetworkManager/NetworkManager.conf
    #restart the network-manager service
    service network-manager restart
		echo "It has been corrected"
	else
    #let the user know the script is not going to make any changes
		echo "NetworkManager.conf is not set to false"
    echo "No changes have been made"
fi
