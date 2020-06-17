#!/bin/bash

IMAGE_NAME=python-django-server-img
CONTAINER_NAME=python-django-server-container


echo "running the docker container"

docker run -d -p 8080:8080 --name $CONTAINER_NAME $IMAGE_NAME


