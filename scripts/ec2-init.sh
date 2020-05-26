#!/bin/bash

# This script tries to leverage the 'user data' functionality of the EC2 service in AWS cloud. This script will be provided as a user data while launching an EC2 instance. When the EC2 instance will be launched, the script will run during boot time, thus, ultimately installing Django.

#enable the debug mode
#set -x

TARGET=~/.local/bin/django-admin.py
LINK_NAME=/usr/local/bin/django-admin

echo "The python version is"
python3 -V

apt-get -y update

# check whether python3-pip is already installed. If not installed, then install the same
dpkg -s python3-pip

	if [ $? -eq 0 ]; then
	echo "python3-pip is already installed!"

	else

	echo "python3-pip  is not installed. Thus, installing the same"
	apt-get -y install python3-pip

	fi

#Printing the pip3 version
echo "Printing the pip3 version"
pip3 -V

# check whether Django is already installed. If not installed, then install the same
pip3 show Django

        if [ $? -eq 0 ]; then
        echo "Django is already installed!"

        else

        echo "Django  is not installed. Thus, installing the same"
        pip3 install Django

        fi

#check whether a symlink already exist. Create one, if it doesn't exist	
test -L $LINK_NAME

        if [ $? -eq 0 ]; then
        echo "symlink already exist"

        else

        echo "symlink doesn't exist. Thus, creating one."
        ln -s $TARGET $LINK_NAME

        fi

#check the Django version
echo "printing the django version"
django-admin --version









