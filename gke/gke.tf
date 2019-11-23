locals {
  project = "sunlit-descent-240209"
  gke = "gke-cluster"
  region = "europe-west6-a"
}

provider "google" {
  credentials = file(var.cred)
  project = local.project
  region = local.region
}

provider "kubernetes" {
  load_config_file       = false
  host                   = google_container_cluster.mygke.endpoint
  token                  = data.template_file.access_token.rendered
  cluster_ca_certificate = base64decode(google_container_cluster.mygke.master_auth[0].cluster_ca_certificate)
}

resource "google_container_cluster" "mygke" {
  name = local.gke
  location = local.region

  remove_default_node_pool = true
  initial_node_count = 1

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  timeouts {
    create = "30m"
    update = "40m"
  }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name = "my-node-pool"
  location = local.region
  cluster = google_container_cluster.mygke.name
  node_count = 1

  management {
    auto_repair  = "true"
    auto_upgrade = "true"
  }

  lifecycle {
    ignore_changes = [initial_node_count]
  }

  node_config {
    image_type   = "COS"
    preemptible = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

resource "kubernetes_service_account" "tf-sa" {
  metadata {
    name = "terraform-sa"
  }
}


# save GKE token into file to be used in the kubernetes provider
data "google_client_config" "current" {
}

data "template_file" "access_token" {
  template = data.google_client_config.current.access_token
}
output "access_token" {
  value = data.google_client_config.current.access_token
}
