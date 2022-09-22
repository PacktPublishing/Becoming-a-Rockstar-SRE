terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("observability-simulation-lab-9351fc370acd.json")

  project = "observability-simulation-lab"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name = "rockstart-network"
}

resource "google_compute_instance" "vm_instance" {
  depends_on   = [google_compute_network.vpc_network]
  name         = "rockstart-server"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-arm64-101-lts"
    }
  }
  network_interface {
    network = "terraform-network"
    access_config {
    }
  }
}
