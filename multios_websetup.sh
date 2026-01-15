#!/bin/bash

#Variable Declaration
#PACKAGE = "httpd weget unzip"
#SVC ="httpd"
URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ARTNAME='2098_health'
TEMPDIR="/tmp/webfiles"

yum --help &> /dev/null
if [ $? -eq 0 ]
then
	echo "Running on CentOs...."
	PACKAGE="httpd wget unzip"                                                          SVC="httpd"
	#installing Dependencies
	echo "##################################"
	echo "Installing Packages."
	echo "##################################"
	sudo yum install $PACKAGE -y > /dev/null
	echo

	#Start and Enable services
	echo "###################################"
	echo "Start and Enable services"
	echo "###################################"
	
	sudo systemctl start $SVC
	sudo systemctl enable $SVC
	echo

	#Creating temp directory
	echo "##################################"
	echo "Starting Artifact deployment"
	echo "###################################"
	mkdir -p $TEMPDIR
	cd $TEMPDIR
	echo

	wget $URL > /dev/null
	unzip  $ARTNAME.zip > /dev/null
	sudo cp -r $ARTNAME/* /var/www/html/
	
	#BOUNCE SERVICE
	echo "####################################"
	echo "Restarting httpd files..."
	echo "####################################"
	systemctl restart httpd
	echo

	#CleanUp
	echo "####################################"
	echo "Removing Temporary files"
	echo "####################################"
	rm -rf $TEMPDIR
	echo  

	sudo systemctl status $SVC
	ls /var/www/html/
else
	 echo "Running on Ubuntu...."
        PACKAGE="apache2 wget unzip"                                                        SVC="apache2"
        #installing Dependencies
        echo "##################################"                                           echo "Installing Packages."
        echo "##################################"
	sudo apt update
        sudo apt install $PACKAGE -y > /dev/null
        echo
                                                                                            #Start and Enable services
        echo "###################################"
        echo "Start and Enable services"
        echo "###################################"                                                                                                                              sudo systemctl start $SVC                                                           sudo systemctl enable $SVC
        echo

        #Creating temp directory
        echo "##################################"
        echo "Starting Artifact deployment"
        echo "###################################"
        mkdir -p $TEMPDIR
        cd $TEMPDIR 
        echo

        wget $URL > /dev/null
        unzip  $ARTNAME.zip > /dev/null
        sudo cp -r $ARTNAME/* /var/www/html/

        #BOUNCE SERVICE
        echo "####################################"
        echo "Restarting httpd files..."
        echo "####################################"
        systemctl restart apache2
        echo

        #CleanUp
        echo "####################################"
        echo "Removing Temporary files"
        echo "####################################"
        rm -rf $TEMPDIR
        echo
fi


