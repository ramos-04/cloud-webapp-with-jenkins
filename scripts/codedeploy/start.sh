#!/bin/bash
#This script start the docker container which holds the python Django application ,thus, ultimately, spinning up the web server

IMAGE_NAME=public.ecr.aws/t4y9j5k5/ramos-python-django:v1
CONTAINER_NAME=python-django-server-container-v1

echo "running the docker container"

docker run -d -p 8080:8080 --name $CONTAINER_NAME $IMAGE_NAME


