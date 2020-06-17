#!/bin/bash

CONTAINER_NAME=python-django-server-container


echo "validating whether the container is running"

if [ $(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME) = "true" ];
then echo "The container is running. Validation is successful";
else 
echo "The container is not running. Validation failed";
 fi
