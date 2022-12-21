# Becoming a Rockstar SRE

## Chapter 12 - Testing Simulation Lab

### Learning objectives

* Learn about Kubernetes-based `software testing`

* Learn how to run a load testing with `k6` tool

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

Folder: `k6`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| simple-test.js | `A k6 simple test script example` |
| load-test.js | `A k6 load test script example` |
| process.env | `Environmental variables used by k6 test scripts` |
| | |

Folder: `node`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| node-api-deployment.yaml | `A K8s manifest file with a Deployement for a simple Node.js API app` |
| node-api-lb-service.yaml | `A K8s manifest file with a LoadBalancer type service for the app` |
| node-api-service.yaml | `A K8s manifest file with a NodePort type service for the app` |
| | |

### Installation

* k6

1. To install `k6` CLI, follow the details from [here](https://k6.io/docs/get-started/installation/)

Alternatively, you can download the latest release from its GitHub [repo](https://github.com/grafana/k6/releases/latest).

```shell
curl -L https://github.com/grafana/k6/releases/download/v0.41.0/k6-v0.41.0-macos-amd64.zip > k6-v0.41.0-macos-amd64.zip
unzip k6-v0.41.0-macos-amd64.zip
sudo install k6-v0.41.0-macos-amd64/k6 /usr/local/bin
```

* Application

1. You can deploy the Node.js API app to the K8s cluster with the following commands

```shell
cd Chapter-12
kubectl apply -f ./node/
```

### Configuration

* k6

1. Wait until the application LoadBalancer is available. You can check that with the following command

`kubectl get svc node-api-rod-lb`

2. After the _LoadBalancer_ service has an external IP address assigned to it, then you can configure the environmental variables

```shell
cd k6
source process.env
```

### Usage

* k6

1. Run the simple test by issuing the following command

`k6 run simple-test.js`

2. Run the load test by using this command

`k6 run load-test.js`

### Explanations

Please check the book chapter **XII** for explanations of the concepts applied in this lab.

## End of the Document
