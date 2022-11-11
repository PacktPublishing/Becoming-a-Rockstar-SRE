terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("project-service-account-key.json")
  project = "provisioning-simulation-lab"
  region  = "southamerica-east1"
  zone    = "southamerica-east1-a"
}

resource "google_compute_network" "vpc_network" {
  name = "rockstar-network"
}

resource "google_compute_autoscaler" "foobar" {
  name   = "rockstar-autoscaler"
  zone   = "southamerica-east1-a"
  target = google_compute_instance_group_manager.foobar.id
  autoscaling_policy {
    max_replicas    = 5
    min_replicas    = 2
    cooldown_period = 60
    cpu_utilization {
      target = 0.8
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name = "rockstar-network"
}

resource "google_compute_instance_template" "foobar" {
  name           = "rockstar-instance-template"
  machine_type   = "e2-medium"
  can_ip_forward = false
  tags = ["foo", "bar"]
  disk {
    source_image = data.google_compute_image.cos_97.id
  }
  network_interface {
    network = google_compute_network.vpc_network.name
  }
  metadata = {
    foo = "bar"
  }
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_target_pool" "foobar" {
  name = "rockstar-target-pool"
}

resource "google_compute_instance_group_manager" "foobar" {
  name = "rockstar-igm"
  zone = "southamerica-east1-a"
  version {
    instance_template  = google_compute_instance_template.foobar.id
    name               = "primary"
  }

  target_pools       = [google_compute_target_pool.foobar.id]
  base_instance_name = "foobar"
}

data "google_compute_image" "cos_97" {
  family  = "cos-97-lts"
  project = "cos-cloud"
}

module "load_balancer" {
  source  = "GoogleCloudPlatform/lb/google"
  version = "~> 2.2.0"
  region       = "southamerica-east1"
  name         = "rockstar-load-balancer"
  service_port = 80
  target_tags  = ["rockstar-target-pool"]
  network      = google_compute_network.vpc_network.name
}
