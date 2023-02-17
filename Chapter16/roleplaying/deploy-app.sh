#!/bin/bash

# Microservices App - create a deployement with replicaset
kubectl create -f manifests/web-game-deployment.yaml

# Microservices App - expose app listener port as a service
kubectl create -f manifests/web-game-service.yaml

# Microservices App - create an external load balancer for the service
kubectl create -f manifests/web-game-lb-service.yaml
