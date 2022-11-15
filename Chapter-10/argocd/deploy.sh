#!/bin/bashß

source process.env

ARGOCD_ADMIN_PASS=`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`

ARGOCD_SERVER=`kubectl -n argocd get svc argocd-server -o jsonpath="{.status.loadBalancer.ingress[].ip}"`

argocd login $ARGOCD_SERVER --username $ARGOCD_ADMIN_NAME --password $ARGOCD_ADMIN_PASS --insecure

argocd app create $APP_NAME --repo $APP_REPO_URL \
 --path $APP_REPO_PATH --dest-server https://kubernetes.default.svc \
 --dest-namespace default
