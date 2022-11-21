# Becoming a Rockstar SRE

## Chapter 8 - Autoscaling Simulation Lab

### Learning objectives

* Learn how to use `Terraform` as an Infrastructure as Code (IaC) tool for `Google Cloud Platform`

* Learn how `autoscaling` and `load balancing` works on GCP using `Terraform`

### Pre-requisite knowledge

*	Familiarity with cloud computing and cloud platforms

*	Basic understanding of `Terraform`

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
| main.tf | `Terraform configuration - an IaC that declares autoscaling instances pool and a load balancer` |
| | |


### Installation

* Terraform

1. To install Terraform CLI, follow the details from [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).

### Configuration

* Terraform

1. Change the provider configuration accordingly:

```yaml
provider "google" {
  credentials = file("project-service-account-key.json")
  project = "autoscaling-simulation-lab"
  region  = "southamerica-east1"
  zone    = "southamerica-east1-a"
}
```

You can consult the available regions and zones on this [document](https://cloud.google.com/compute/docs/regions-zones).

2. Replace `credentials` filename per the one you have downloaded from GCP console. Fix the project id, region, and zone in the same block.


### Usage

* Terraform

```shell
cd terraform
terraform init
terraform fmt
terraform validate
terraform apply
terraform destroy
```

### Explanations

Please check the book chapter VIII for explanations of the concepts applied in this lab.


## End of the Document
