cluster_name = "my-cluster"
location = "us-central1-a"
initial_node_count = 3
min_master_version = "1.20"
logging_service = "logging.googleapis.com"
monitoring_service = "monitoring.googleapis.com"
http_load_balancing_disabled = false
machine_type = "n1-standard-1"
disk_size_gb = 100
service_account = "my-sa@project-id.iam.gserviceaccount.com"
oauth_scopes = ["https://www.googleapis.com/auth/compute", "https://www.googleapis.com/auth/devstorage.read_only"]
labels = {
  env = "production"
}
taint = [
  {
    key = "dedicated",
    value = "gpu",
    effect = "NO_SCHEDULE"
  }
]
preemptible = false
local_ssd_count = 1
tags = ["production"]
boot_disk_kms_key = "projects/project-id/locations/global/keyRings/my-key-ring/cryptoKeys/my-key"
enable_integrity_monitoring = true
enable_secure_boot = true
