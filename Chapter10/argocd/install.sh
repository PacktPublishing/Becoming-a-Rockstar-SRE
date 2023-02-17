#!/bin/bash

# Configure kubectl to connect to a GKE cluster
gcloud container clusters get-credentials cluster-1 --zone <your_closest_region> --project <your_project_id>
# Create a namespace for Argo CD
kubectl create namespace argocd
# Deploy Argo CD server
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# Change Argo CD service to LoadBalancer type
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
