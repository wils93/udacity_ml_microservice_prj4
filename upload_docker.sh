#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create dockerpath
dockerpath=wils93/udacity_ml_microservice_prj4

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"

docker login -u wils93
docker tag $1 $dockerpath:latest

# Step 3:
# Push image to a docker repository
docker push $dockerpath:latest
