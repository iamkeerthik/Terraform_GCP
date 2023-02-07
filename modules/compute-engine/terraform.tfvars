project_id = "my-project"
firewall_name = "allow-ssh-http"
firewall_allow_ssh = "22"
firewall_allow_http = "80"
instance_name = "my-instance"
instance_type = "n1-standard-1"
instance_zone = "us-central1-a"
instance_boot_disk_size = "10"
instance_boot_disk_type = "pd-ssd"
instance_tags = ["web","app"]
instance_service_account = "my-instance-service-account@my-project.iam.gserviceaccount.com"
subnet_self_link = "google_compute_subnetwork.my_subnet.self_link"
instance_metadata = { env = "production" }
instance_labels = { cost-center = "web-team" }
instance_preemptible = false
instance_automatic_restart = true
