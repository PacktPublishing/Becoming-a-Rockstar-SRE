# Becoming an SRE Rockstar

## Chapter 10 - Advanced GitOps Lab

### Learning objectives

* Learn how to deploy an app using GitOps approach

* Learn how use Argo CD as a GitOps platform

### Pre-requisite knowledge

*	Familiarity with Kubernetes

*	Basic notions on Node.js (JavaScript) programming language

*	Good understanding of YAML (Yet Another Markup Language)

### Kubernetes cluster

This lab runs on any K8s cluster with few adjusts on the ingresses, we recommend using a free trial account on Google Cloud Platform. You can create one through this [documentation](https://cloud.google.com/free). You can download and install the Google CLI `gcloud` by checking this [document](https://cloud.google.com/sdk/docs/install).

In case you use a GCP account for this lab, we provided the Google Kubernetes Engine (GKE) recommended configuration below:

* GKE Configuration

| **Parameter** | **Value** |
|:--------------------------------|:--------------------------------|
| GKE mode | `Standard with static K8s version` |
| Location type | `Zonal` |
| Release channel | `None` |
| Kubernetes version | `v1.24.6-gke.1500` |
| Number of nodes | `3` |
| Machine type | `e2-medium` |
| Image type | `cos_containerd` |
| | |

* GKE cluster creation

You can create a K8s cluster for this lab with the following commands:

```
gcloud auth login
gcloud container clusters create gitops-sim --no-enable-autoupgrade --enable-service-externalips \
 --enable-kubernetes-alpha --region=<your_closest_region> --cluster-version= v1.24.6-gke.1500 \
 --machine-type=e2-medium --monitoring=NONE
```

* kubectl configuration

You can configure your local `kubectl` environment and credentials with the following command:

```
gcloud container clusters get-credentials gitops-sim \
 --zone <your_closest_region> --project <your_project_id>
```

### Lab Contents

* Argo CD

Argo CD is installed through its default K8s manifest file located [here](https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml).

* Node.js API app

There's a dummy Node.js API available as K8s manifest files [here](https://github.com/kyndryl-open-source/gitops-app-examples.git). It points to a public Docker image located at the Docker Hub.

```
image: rod4n4m1/node-api:0.1.2
```

* Folder contents: `argocd`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| deploy.sh | `Automation script to deploy latest stable Argo CD release to a K8s cluster` |
| install.sh | `Automation script to create an Argo CD app and deploy the Node.js API using GitOps approach to a K8s cluster` |
| README.d | `This file` |
| process.env | `Example of enviromental variables definition to configure the deploy.sh script` |
| | |


### Installation

* Install Argo CD

This automation script will deploy the latest stable Argo CD relase to a K8s cluster under the `argocd` namespace.

```shell
cd argo-cd
./install.sh
```

* More information [here](https://argo-cd.readthedocs.io/en/stable/getting_started/)


### Configuration

* Change environmental variables accordingly

**process.env**

```shell
#!/bin/bash

export ARGOCD_ADMIN_NAME="admin"
export APP_NAME="simple-node-api"
export APP_REPO_URL="https://github.com/kyndryl-open-source/gitops-app-examples.git"
export APP_REPO_PATH="simple-node-api"
```

### Deployment

* Deploy a Simple Node.js API

This will deploy a K8s app as an Argo CD app to the cluster where it's running. An Argo CD app synchronizes with IaC and app manifest files in a GitHub repo.

```shell
cd argo-cd
./deploy.sh
```

### Explanations

Please check the book chapter X for explanations of the concepts applied in this lab.

## End of document
