# resource "google_service_account" "default" {
#   account_id   = "service-account-id"
#   display_name = "Service Account"
# }

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "gke_cluster" {
  name                     = "${var.name}-cluster"
  location                 = "us-central1-a"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = data.google_compute_network.vpc_network.self_link
  subnetwork               = data.google_compute_subnetwork.private_subnet1.self_link
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  # networking_mode          = "VPC_NATIVE"

  # Optional, if you want multi-zonal cluster
  node_locations = [
    "us-central1-b"
  ]

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  # workload_identity_config {
  #   workload_pool = "devops-v4.svc.id.goog"
  # }

  ip_allocation_policy {
    # cluster_secondary_range_name  = "k8s-pod-range"
    # services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }
}


resource "google_container_node_pool" "general" {
  name       = "${var.name}-nodepool"
  cluster    = google_container_cluster.gke_cluster.id
  node_count = var.node_count

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = var.gke_node_type
    disk_size_gb = 30
    disk_type    = "pd-standard"
    labels = {
      role = "general"
    }
    service_account = data.google_service_account.k8s_service_account.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}
