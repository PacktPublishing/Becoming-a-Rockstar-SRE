#!/bin/bash

# Prometheus - create a namespace for monitoring
kubectl create namespace monitoring

# Prometheus Server - create a clusterrole and clusterrolebinding
kubectl create -f prom-server/prometheus-rbac.yaml

# Prometheus Server - create a configmap with prometheus server config
kubectl create -f prom-server/prometheus-configmap.yaml

# Prometheus Server - create a storage StorageClass
kubectl create -f prom-server/storage-class.yaml

# Prometheus Server - create a persistentVolumeClaim for prometheus
kubectl create -f prom-server/prometheus-pvc.yaml

# Prometheus Server - create a deployment for prometheus server
kubectl create  -f prom-server/prometheus-deployment.yaml

# Prometheus Server - check if prometheus servers is running
kubectl get deployments -n monitoring

# Prometheus Server - create a service to expose a NodePort for the prometheus dashboard
kubectl create -f prom-server/prometheus-service.yaml

# kubectl create secret tls secure-ingress \
#    --namespace monitoring \
#    --key server.key \
#    --cert server.crt

# Prometheus Server - Create a basic ingress with external LB
kubectl create -f prom-server/prometheus-basic-ingress.yaml

# K8s - deploy kube-state-metrics
kubectl apply -f kube-state/

# AlertManager - create config maps
kubectl create -f prom-alert/alertmanager-configmap.yaml
kubectl create -f prom-alert/alertmanager-templateconfig.yaml

# AlertManager - create deployment
kubectl create -f prom-alert/alertmanager-deployment.yaml

# AlertManager - create service
kubectl create -f prom-alert/alertmanager-service.yaml

# Blackbox exporter - create config map
kubectl create -f prom-blackbox/blackbox-exporter-configmap.yaml

# Blackbox exporter - create deployment
kubectl create -f prom-blackbox/blackbox-exporter-deployment.yaml

# Blackbox exporter - create service
kubectl create -f prom-blackbox/blackbox-exporter-service.yaml

# Blackbox exporter - test service
# kubectl -n monitoring port-forward svc/blackbox-service 9115:9115

# Grafana
# https://grafana.com/docs/grafana/latest/setup-grafana/installation/kubernetes/

# Grafana - create config map
kubectl create -f grafana/grafana-config.yaml

# Grafana - create deployment
kubectl create -f grafana/grafana-deployment.yaml

# Grafana - create service
kubectl create -f grafana/grafana-service.yaml

# Grafana - create basic ingress
kubectl create -f grafana/grafana-basic-ingress.yaml

# Grafana - access UI
# kubectl -n monitoring port-forward svc/grafana-service 3000:3000
