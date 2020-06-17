#!/bin/bash

IMAGE_NAME=python-django-server-img
FILE_NAME=python-django-server-img.tar
GITHUB_URL=https://github.com/ramos-04/cloud-project.git

apt-get update

apt-get install -y git

# cloning the repository
git clone $GITHUB_URL

cd cloud-project/webserver

# building the python django docker image
echo "building the python docker image"
docker build -t $IMAGE_NAME .

# listing docker images
echo "listing docker images: "
docker images


#echo "loading the docker image from a tar file"
#docker load --input $FILE_NAME


