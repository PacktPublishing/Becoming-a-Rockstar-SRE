# Becoming a Rockstar SRE

## Chapter 16 - Chaos Simulation Lab

### Learning objectives

* Learn about `chaos engineering` tests

* Learn how to use `LitmusChaos operator` for testing Kubernetes deployments

### Pre-requisite knowledge

* Familiarity with JavaScript and Node.js

* Basic understanding of `Kubernetes`, `operators`, and `CRDs`

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

Folder: `node`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| web-app-deployment.yaml | `A K8s manifest file with a Deployment for a simple Node.js web app` |
| web-app-lb-service.yaml | `A K8s manifest file with a LoadBalancer type service for the web app` |
| web-app-service.yaml | `A K8s manifest file with a NodePort type service for the web app` |
| | |

Folder: `litmus`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| web-chaos-sa.yaml | `A K8s manifest file with a ServiceAccount, Role, RoleBinding used by the ChaosEngine to have privileges to API resources` |
| web-pod-delete.yaml | `A K8s manifest file to create a ChaosEngine based on the pod-delete ChaosExperiment` |
| | |

Folder: `solutions`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| web-game-deployment-good.yaml | `A fixed K8s manifest file with a Deployement for a simple Node.js web app` |
| web-game-lb-service-good.yaml | `A fixed K8s manifest file with a LoadBalancer type service for the app` |
| | |

### Installation

* Application

1. You can deploy the Node.js web app to the K8s cluster with the following commands:

```shell
cd Chapter-16/chaos
kubectl apply -f ./node/
```

**Expected output:**

```shell
deployment.apps/web-app created
service/web-app-lb created
service/web-app-svc created
```

* LitmusChaos operator

1. Install LitmusChaos operator by issuing the following command:

`kubectl apply -f https://litmuschaos.github.io/litmus/litmus-operator-v2.14.0.yaml`

2. Install pod-delete ChaosExperiment from the Chaos Hub:

```shell
kubectl apply -f https://hub.litmuschaos.io/api/chaos/2.14.0?file=charts/generic/pod-delete/experiment.yaml

```

**Expected output:**

`chaosexperiment.litmuschaos.io/pod-delete created`

### Configuration

* LitmusChaos operator

1. Create a ServiceAccount for the ChaosEngine

```shell
kubectl apply -f web-chaos-sa.yaml
serviceaccount/web-chaos-sa created
role.rbac.authorization.k8s.io/web-chaos-sa created
rolebinding.rbac.authorization.k8s.io/web-chaos-sa created
```

### Usage

1. Annotate the app to tag it for chaos experimentation:

`kubectl annotate deploy/web-app litmuschaos.io/chaos="true"`

2. Create a ChaosEngine based on pod-delete ChaosExperiment:

`kubectl apply -f web-pod-delete.yaml`

**Expected output:**

`chaosengine.litmuschaos.io/web-chaos created`

3. Check if the pods are getting deleted by the ChaosEngine

`kubectl get pods`

4. Verify how the app behaves during the experiment. Use a observability platform like the one discussed in the Chapter 4.

5. Check the ChaosResult report

`kubectl describe chaosresult web-chaos-pod-delete`

### Explanations

Please check the book chapter XVI for explanations of the concepts applied in this lab.

## End of the Document
