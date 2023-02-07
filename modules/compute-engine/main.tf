resource "google_compute_instance" "vm_instance_private" {
  name         = "${var.name}-vm"
  machine_type = var.instance_type
  zone         = var.instance_zone
  tags         = ["rdp","http"]
  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2016"
      size = 50
    }
     
  }

#   resource "google_compute_disk" "example_data_disk" {
#   name  = "example-data-disk"
#   type  = "pd-standard"
#   size  = 50
#   zone  = "us-central1-a"
#   }

#   disk {
#     source_image = data.google_compute_image.latest_windows_server.self_link
#     auto_delete  = true
#     boot         = true
#   }
#   disk {
#     source = google_compute_disk.example_data_disk.self_link
#     auto_delete = true
#   }

#   metadata = {
#     sysprep-specialize-script-ps1 = data.template_file.windows-metadata.rendered
#   }

  network_interface {
    network       = data.google_compute_network.vpc_network.self_link
    subnetwork    = data.google_compute_subnetwork.private_subnet1.self_link
    # access_config {
    #      assign_external_ip = false
    #  }
  }
}