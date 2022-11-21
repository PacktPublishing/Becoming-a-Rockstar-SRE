#!/bin/bash

# Read the defined environmental variables
source process.env
# Get the initial admin password, you should change that
ARGOCD_ADMIN_PASS=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`
# Get the IP address for the LoadBalancer service, it assumes you are using a K8s cluster using a cloud platform
ARGOCD_SERVER=`kubectl -n argocd get svc argocd-server -o jsonpath="{.status.loadBalancer.ingress[].ip}"`
# Logins into Argo CD server
argocd login $ARGOCD_SERVER --username $ARGOCD_ADMIN_NAME --password $ARGOCD_ADMIN_PASS --insecure
# Creates an Argo CD app based on the variables from process.env
argocd app create $APP_NAME --repo $APP_REPO_URL \
 --path $APP_REPO_PATH --dest-server https://kubernetes.default.svc \
 --dest-namespace default
