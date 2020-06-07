#!/bin/bash

# This script is used to install docker on Linux ubuntu 

# If any of the commands returns a non-zero(error) status, then it could be caught and the script execution can be terminated immediately
set -e

# used to catch errors
trap 'catcherror $? $LINENO' ERR

# The below function acts like a catch block used in exception handling which is observed in different programming languages. It will print the error code and the line number on which the error was generated. The script will be exited later.

catcherror()
{
  echo "Error code $1 generated on Line $2"
  exit 1
}

# printing the username
echo "Username is $(whoami)"

# validating the user (the script should be run as a root user)
        if [ "$(whoami)" != "root" ]; then
                        echo  "Script should be run as a root user"
                        exit -1
        fi

# update the packages
apt update -y

# installing some prerequisites which let 'apt' use packages over HTTPS
apt install -y apt-transport-https ca-certificates curl software-properties-common

# adding the GPG key for the official Docker repository to our system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# adding the Docker repository to APT sources
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# updating the package database with the Docker packages from the newly added repo
apt update -y

# installing docker
apt install -y docker-ce

# validating the installation of docker by checking the version
docker version
