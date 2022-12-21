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
| simple-test.js | `A k6 simple test script example` |
| load-test.js | `A k6 load test script example` |
| process.env | `Environmental variables used by k6 test scripts` |
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

1. Run the simple test by issuing the following command:

`k6 run simple-test.js`

2. Run the load test by using this command:

`k6 run load-test.js`

### Explanations

Please check the book chapter XVI for explanations of the concepts applied in this lab.

## End of the Document
