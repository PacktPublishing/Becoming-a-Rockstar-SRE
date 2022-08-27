
kubectl expose deployment node-api-rod --name node-api-rod-svc \
    --type NodePort --protocol TCP --port 8080 --target-port 8080

# this works on GKE
#kubectl expose deployment node-api-rod --name node-api-rod-lb \
#    --type LoadBalancer --port 60000 --target-port 8080
