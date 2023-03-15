#!/bin/bash


pwd

ls

docker version

cd webserver

echo "building the python docker image"

docker build -t $IMAGE_NAME:$IMAGE_VERSION .

echo "listing docker images: "

docker images

echo "tag your image so you can push the image to this repository"

docker tag $IMAGE_NAME:$IMAGE_VERSION public.ecr.aws/t4y9j5k5/$IMAGE_NAME:$IMAGE_VERSION

echo "listing docker images to check the new tag "

docker images

echo "Retrieve an authentication token and authenticate your Docker client to your registry."

#aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/t4y9j5k5

echo "pushing the image to the registry"

#docker push public.ecr.aws/t4y9j5k5/$IMAGE_NAME:$IMAGE_VERSION
