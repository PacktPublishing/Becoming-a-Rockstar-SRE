#!/bin/bash

# Microservices App - create a deployement with replicaset
kubectl create -f k8s/node-api-deployment.yaml

# Microservices App - expose app listener port as a service
kubectl create -f k8s/node-api-service.yaml

# Microservices App - create an external load balancer for the service
kubectl create -f k8s/node-api-lb-service.yaml
