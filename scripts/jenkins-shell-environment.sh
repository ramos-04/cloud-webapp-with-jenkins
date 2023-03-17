#!/bin/bash


pwd

ls

echo "printing the docker version"

docker version

cd webserver

echo "building the python docker image"

docker build -t $LOCAL_IMAGE_NAME:$IMAGE_VERSION .

echo "listing the new docker images: "

docker images

echo "tag your image so you can push the image to this repository"

docker tag $LOCAL_IMAGE_NAME:$IMAGE_VERSION $ECR_REPOSITORY_NAME/$LOCAL_IMAGE_NAME:$IMAGE_VERSION

echo "listing docker images to check the new tag "

docker images

echo "Retrieve an authentication token and authenticate your Docker client to your registry."

aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_REPOSITORY_NAME

echo "pushing the image to the registry"

docker push $ECR_REPOSITORY_NAME/$LOCAL_IMAGE_NAME:$IMAGE_VERSION





