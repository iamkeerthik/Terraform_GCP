# data "google_compute_image" "latest_windows_server" {
#   family  = "windows-server"
#   project = var.gcp_project
# }

data "google_compute_network" "vpc_network" {
  project = var.gcp_project
  name = "${var.name}-vpc"
}

data "google_compute_subnetwork" "private_subnet1" {
  project = var.gcp_project
  name          = "${var.name}-private-subnet1-us-central1"
#   network       = data.google_compute_network.vpc_network.self_link
  region        = "us-central1"
}