# Becoming an SRE Rockstar

## Chapter 6 - Provisioning Simulation Lab

### Learning objectives

* Learn how to use Terraform as an Infrastructure as Code (IaC) tool for Google Cloud Platform

* Learn how to use Google Cloud SDK for Node.js as an IaC tool.

### Pre-requisite knowledge

* Familiarity with cloud computing and cloud platforms

* Basic notions on Node.js (JavaScript) programming language


### Cloud Platform

The first lab part runs on any Cloud Platform that is supported by Terraform with few adjusts on the provider. The second part only works on Google Cloud Platform (GCP). We recommend using a free trial account on GCP. You can create one through this [documentation](https://cloud.google.com/free). You can download and install the Google CLI `gcloud` by checking this [document](https://cloud.google.com/sdk/docs/install).

* Google Cloud Project Id

1. You can login into your GCP account with the following command:

`gcloud auth login`

2. Then you can create a project in the console or by issuing the following command:

`gcloud projects create my-project --set-as-default`

* Google Application Default Credentials

1. To create the necessary credentials for the SDK, use this command:

`gcloud auth application-default login`

More information at this [document](https://cloud.google.com/docs/authentication#adc).

* Google Service Account Key

1. To enable GCP and generate a service account key for the Terraform provider, please follow this [documentation](https://learn.hashicorp.com/tutorials/terraform/google-cloud-platform-build?in=terraform/gcp-get-started#set-up-gcp).

2. Download your Service Account Key as JSON file and copy it to `terraform` directory.

### Contents

* Terraform

Folder: `terraform`

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| main.tf | `Terraform configuration - a IaC definition file that uses HCL` |
| | |

* Cloud SDK

| **File / folder** | **Description** |
|:--------------------------------|:--------------------------------|
| app.js | `Node.js app code that uses the Google Cloud SDK for Node.js library` |
| package.json | `JSON file that contains the description of the Node.js app` |
| package-lock.json | `JSON file that contains the last state of the installed Node.js packages` |
| process.env-example | `Shell script file that contains an example of the app configuration` |
| | |

### Installation

* Node.js and npm

1. To install Node.js and npm, check the documentation [here](https://nodejs.org/en/download/).

* Terraform

1. To install Terraform CLI, follow the details from [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).

* Google Cloud SDK for Node.js

1. To install the npm package for the Cloud SDK, do the following:

```
cd cloud-sdk
npm install
```

### Configuration

* Terraform

1. Change the provider configuration accordingly:

```
provider "google" {
  credentials = file("project-service-account-key.json")
  project = "provisioning-simulation-lab"
  region  = "southamerica-east1"
  zone    = "southamerica-east1-a"
}
```

You can consult the available regions and zones on this [document](https://cloud.google.com/compute/docs/regions-zones).

2. Replace `credentials` filename per the one you have downloaded from GCP console. Fix the project id, region, and zone in the same block.

* Cloud SDK

1. Copy `process.env-example` to `process.env`

2. Change the values on `process.env` to reflect your environment parameters

```
export GCP_PROJECT_ID="provisioning-simulation-lab"
export GCP_MACHINE_TYPE="e2-medium"
export GCP_MACHINE_IMAGE_PROJECT="cos-cloud"
export GCP_MACHINE_IMAGE_FAMILY="cos-101-lts"
export GCP_ZONE="southamerica-east1-a"
export GCP_NETWORK_NAME="default"
```

You can consult the values for the available machine images on this [document](https://cloud.google.com/compute/docs/images/os-details).


### Usage

* Terraform

```
cd terraform
terraform init
terraform fmt
terraform validate
terraform apply
terraform destroy
```

* Google Cloud SDK

```
cd cloud-sdk
source process.env
node app.js listCustomImages
node app.js createInstance rockstar-server default
node app.js getInstance rockstar-server
node app.js startInstance rockstar-server
node app.js stopInstance rockstar-server
node app.js deleteInstance rockstar-server
```

## End of document
