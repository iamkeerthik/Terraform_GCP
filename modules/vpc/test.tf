# module "network" {
#   source = "terraform-google-modules/network/google"
#   version = "4.0.0"

#   name = var.vpc_name
#   ipv4_range = var.vpc_cidr_range
#   auto_create_subnetworks = false
#   delete_default_internet_gateway_routes = "true"

#   subnets = [
#     {
#       subnet_name           = "public"
#       subnet_ip             = "10.0.0.0/24"
#       subnet_region         = "us-west2"
#       subnet_private_access = "false"
#       subnet_flow_logs      = "false"
#     },
#     {
#       subnet_name           = "private"
#       subnet_ip             = "10.0.1.0/24"
#       subnet_region         = "us-west2"
#       subnet_private_access = "true"
#       subnet_flow_logs      = "false"
#     }
#   ]

#   routes = [
#     {
#       name              = "egress-internet"
#       description       = "Default route through IGW to access internet"
#       destination_range = "0.0.0.0/0"
#       next_hop_internet = "true"
#     }
#   ]
# }

# # resource "google_compute_subnetwork" "my_subnet" {
# #   name          = var.subnet_name
# #   ip_cidr_range = var.subnet_ip_range
# #   region        = var.subnet_region
# #   network       = module.network.network_self_link
# # }

# # resource "google_compute_firewall" "my_firewall" {
# #   name    = var.firewall_name
# #   network = module.network.network_self_link

# #   allow {
# #     protocol = var.firewall_protocol
# #     ports    = [var.firewall_port]
# #   }

# #   source_ranges = [var.firewall_src_range]
# # }

