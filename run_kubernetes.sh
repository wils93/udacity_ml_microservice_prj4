#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=wils93/udacity_ml_microservice_prj4

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run udacity-ml \
    --image=$dockerpath \
    --image-pull-policy="Always"

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Forward the container port to a host
kubectl port-forward udacity-ml 8000:80
