#!/bin/bash

gcloud container clusters get-credentials cluster-1 --zone southamerica-west1-a --project observability-simulation-lab

kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
