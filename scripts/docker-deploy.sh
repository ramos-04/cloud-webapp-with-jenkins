#!/bin/bash

# This script is for the purpose of deployment. It will clone the code from github, then build docker images, and eventually spin up containers out of it. Before running this script, please make sure that your system has provision to run docker commands without sudo 

# declare local variables

GITHUB_URL=https://github.com/ramos-04/cloud-project.git
IMAGE_NAME=python-django-server-img
CONTAINER_NAME=python-django-server-container

# If any command returns a non-zero(error) status, then it could be caught and the script execution can be terminated immediately
set -e

# used to catch errors
trap 'catcherror $? $LINENO' ERR

# The below function acts like a catch block used in exception handling(observed in different programming languages). It will print the error code and the line number on which the error was generated. The script will be exited later
catcherror()
{
  echo "Error code $1 generated on Line $2"
  exit 1
}

# cloning the repository
git clone $GITHUB_URL

cd cloud-project/webserver

# building the python django docker image
echo "building the python docker image"
docker build -t $IMAGE_NAME .

# listing docker images
echo "listing docker images: "
docker images

# running the container
echo "spinning up a container"
docker run -d -p 8080:8080 --name $CONTAINER_NAME $IMAGE_NAME

# listing the containers
echo "listing the containers"

docker ps -a


