resource "google_container_cluster" "gke_cluster" {
  name               = var.cluster_name
  location           = var.location
  initial_node_count = var.initial_node_count
  min_master_version = var.min_master_version
  logging_service    = var.logging_service
  monitoring_service = var.monitoring_service
  addons_config {
    http_load_balancing {
      disabled = var.http_load_balancing_disabled
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  # node_config {
  #   machine_type           = var.machine_type
  #   disk_size_gb           = var.disk_size_gb
  #   service_account        = var.service_account
  #   oauth_scopes           = var.oauth_scopes
  #   labels                 = var.labels
  #   taint                  = var.taint
  #   preemptible            = var.preemptible
  #   local_ssd_count        = var.local_ssd_count
  #   tags                   = var.tags
  #   boot_disk_kms_key      = var.boot_disk_kms_key
  #   shielded_instance_config {
  #     enable_integrity_monitoring = var.enable_integrity_monitoring
  #     enable_secure_boot = var.enable_secure_boot
  #   }
  # }
}

resource "google_container_node_pool" "general" {
  name       = "general"
  cluster    = google_container_cluster.gke_cluster.id
  node_count = 1

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "general"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
