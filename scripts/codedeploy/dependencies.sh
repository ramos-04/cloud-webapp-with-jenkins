#!/bin/bash

#This script is used to extract/load the docker image out of a tar package.  

#IMAGE_NAME=python-django-server-img
FILE_PATH=/opt/docker-image/python-django-server-img.tar
#GITHUB_URL=https://github.com/ramos-04/cloud-project.git

#apt-get update

#apt-get install -y git

# cloning the repository
#git clone $GITHUB_URL

#cd cloud-project/webserver

# building the python django docker image
#echo "building the python docker image"
#docker build -t $IMAGE_NAME .

echo "printing the present working directory"
pwd

echo "listing the current directory contents"
ls

#echo "listing the /opt directory contents"
#ls /opt/


#echo "loading the docker image from a tar file"
#docker load --input $FILE_PATH

echo "dowloading the docker image from the ECR repository"
docker pull public.ecr.aws/t4y9j5k5/ramos-python-django:v1

# listing docker images
echo "listing docker images"
docker images
