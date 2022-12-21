# Becoming a Rockstar SRE

## Chapter 16 - Roleplaying Simulation Lab

### Learning objectives

* Learn about the `wheel-of-misfortune` game

* Learn how to resolve a typos in the manifest files scenario

### Pre-requisite knowledge

* Familiarity with JavaScript and Node.js

* Basic understanding of containers and `Kubernetes`

### Cloud Platform

This lab runs on any K8s cluster with few adjusts on the ingresses, we recommend using a free trial account on Google Cloud Platform. You can create one through this [documentation](https://cloud.google.com/free). You can download and install the Google CLI `gcloud` by checking this [document](https://cloud.google.com/sdk/docs/install).

In case you use a GCP account for this lab, we provided the Google Kubernetes Engine (GKE) recommended configuration below:

* GKE Configuration

| **Parameter** | **Value** |
|:--------------------------------|:--------------------------------|
| GKE mode | `Standard with static K8s version` |
| Location type | `Zonal` |
| Release channel | `None` |
| Kubernetes version | `v1.24.x` |
| Number of nodes | `3` |
| Machine type | `e2-medium` |
| Image type | `cos_containerd` |
| | |

* GKE cluster creation

You can create a K8s cluster for this lab with the following commands:

```shell
gcloud auth login
gcloud container clusters create testing-sim --no-enable-autoupgrade --enable-service-externalips \
 --enable-kubernetes-alpha --region=<your_closest_region> --cluster-version= v1.24.6-gke.1500 \
 --machine-type=e2-medium --monitoring=NONE
```

* kubectl configuration

You can configure your local `kubectl` environment and credentials with the following command:

```shell
gcloud container clusters get-credentials testing-sim \
 --zone <your_closest_zone> --project <your_project_id>
```

### Contents

Folder: `microservices`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| docker-build.sh | `Shell script used to build and push the Docker image` |
| Dockerfile | `Docker commands to build the image` |
| package.json | `npm manifest file with project information` |
| package-lock.json | `npm manifest file with locked dependencies and versions` |
| static | `Folder with static HTML for the web app` |
| views | `Folder with dynamic HTML for the web app` |
| web-game.js | `A simple Node.js web app` |
| | |

Folder: `manifests`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| web-game-deployment.yaml | `A K8s manifest file with a Deployement for a simple Node.js web app (with a typo)` |
| web-game-lb-service.yaml | `A K8s manifest file with a LoadBalancer type service for the web app (with a typo)` |
| web-game-service.yaml | `A K8s manifest file with a NodePort type service for the web app` |
| | |

Folder: `solutions`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| web-game-deployment-good.yaml | `A fixed K8s manifest file with a Deployement for a simple Node.js web app` |
| web-game-lb-service-good.yaml | `A fixed K8s manifest file with a LoadBalancer type service for the app` |
| | |

### Installation

* Application

1. You can deploy the Node.js web-game app to the K8s cluster with the following commands:

```shell
cd Chapter-16/roleplaying
kubectl apply -f ./manifests/
```

### Troubleshooting

* Application

1. Check if the pods are running. You can run the following command:

`kubectl get pods`

2. Find out what's wrong with the Deployment.

* Pro-tip: You see more information with `kubectl describe pod <pod-id>`

3. Change the web-game-deployment.yaml file to fix it, then delete the previous Deployment object and create a new one

```shell
vi web-game-deployment.yaml
kubectl delete deployment web-game-deployment
kubectl apply -f web-game-deployment.yaml
```

* **Pro-tip:** you can use the following kubectl command to change the image of a Deployment.

`kubectl set image deployment/web-game web-game=$image:$version`

4. Try to open the application from your laptop browser using the LoadBalancer service IP address and port

`http://<load-balancer-ip>:60000/`

5. Figure out what's wrong with the LoadBalancer service

6. Change the web-game-lb-service.yaml file to fix it, then delete the previous LoadBalancer object and create a new one:

```shell
vi web-game-lb-service.YAML
kubectl delete service web-game-lb-service
kubectl apply -f web-game-lb-service.yaml
```

* **Pro-tip:** you can use the following kubectl command to patch a service.

`kubectl patch service web-game-lb -p '{"spec":{"selector":{"app": "web-game"}}}'`

### Explanations

Please check the book chapter XVI for explanations of the concepts applied in this lab.

## End of the Document
