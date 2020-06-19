#!/bin/bash

#This script stops and removes all the docker containers. Also, it deletes all the docker images

echo "stopping all the containers"

docker stop $(docker ps -a -q)

echo "removing all the containers"

docker rm $(docker ps -a -q)

echo "deleting all the docker images"

docker rmi $(docker images -a -q)
