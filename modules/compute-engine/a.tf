# module "compute_engine" {
#   source = "terraform-google-modules/compute-engine/google"
#   version = "4.0.0"

#   project_id = var.project_id
#   firewall_name = var.firewall_name
#   firewall_allow_ssh = var.firewall_allow_ssh
#   firewall_allow_http = var.firewall_allow_http

#   instances = [
#     {
#       name                  = var.instance_name
#       machine_type          = var.instance_type
#       zone                  = var.instance_zone
#       subnetwork            = var.subnet_self_link
#       boot_disk_size_gb     = var.instance_boot_disk_size
#       boot_disk_type        = var.instance_boot_disk_type
#       tags                  = var.instance_tags
#       service_account_email = var.instance_service_account
#       metadata              = var.instance_metadata
#       labels                = var.instance_labels
#     #   scheduling {
#     #     preemptible = var.instance_preemptible
#     #     automatic_restart = var.instance_automatic_restart
#     #   }
#     }
#   ]
# }

# resource "google_compute_firewall" "my_firewall" {
#   name    = var.firewall_name
#   network = var.network_self_link

#   allow {
#     protocol = "tcp"
#     ports    = [var.firewall_allow_ssh, var.firewall_allow_http]
#   }

#   source_ranges = ["0.0.0.0/0"]
# }

