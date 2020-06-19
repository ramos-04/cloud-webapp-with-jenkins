#!/bin/bash
#This script start the docker container which holds the python Django application ,thus, ultimately, spinning up the web server

IMAGE_NAME=python-django-server-img
CONTAINER_NAME=python-django-server-container

echo "running the docker container"

docker run -d -p 8080:8080 --name $CONTAINER_NAME $IMAGE_NAME


