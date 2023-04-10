resource "google_compute_network" "demo_vpc_network" {
  project                 = var.gcp_project
  name                    = "${var.name}-vpc"
  auto_create_subnetworks = false
  # delete_default_internet_gateway_routes = "true"

}

resource "google_compute_subnetwork" "demovpc_private_subnet1" {
  name                     = "${var.name}-private-subnet1-us-central1"
  ip_cidr_range            = var.private_subnet_cidr_range
  network                  = google_compute_network.demo_vpc_network.id
  region                   = var.region
  private_ip_google_access = true
  depends_on               = [google_compute_network.demo_vpc_network]
}

resource "google_compute_subnetwork" "demovpc_public_subnet1" {
  name                     = "${var.name}-public-subnet1-us-central1"
  ip_cidr_range            = var.public_subnet_cidr_range
  network                  = google_compute_network.demo_vpc_network.id
  region                   = var.region
  private_ip_google_access = true
  depends_on               = [google_compute_network.demo_vpc_network]
}

resource "google_compute_router" "router" {
  name    = "${var.name}-router"
  region  = google_compute_subnetwork.demovpc_public_subnet1.region
  network = google_compute_network.demo_vpc_network.id

  bgp {
    asn = 64514
  }
  depends_on = [google_compute_network.demo_vpc_network, google_compute_subnetwork.demovpc_public_subnet1]
}

resource "google_compute_address" "nat_ip" {
  name   = "${var.name}-nat-ip"
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.name}-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_ip.name]

  # source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES" #allow all subnet to use nat
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.demovpc_private_subnet1.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  depends_on = [google_compute_router.router]
}

resource "google_compute_firewall" "jump_firewall_rdp" {
  name    = "${var.name}-jump-allow-rdp"
  network = google_compute_network.demo_vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["103.171.59.0/24"]
  target_tags = ["rdp-jump"]
  depends_on    = [google_compute_network.demo_vpc_network]
}

resource "google_compute_firewall" "demovpc_firewall_rdp" {
  name    = "${var.name}-allow-rdp"
  network = google_compute_network.demo_vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }

  source_ranges = ["10.0.0.0/16"]
  target_tags = ["rdp"]
  depends_on    = [google_compute_network.demo_vpc_network]
}

# Allow http
resource "google_compute_firewall" "allow-http" {
  name    = "${var.name}-allow-http"
  network = google_compute_network.demo_vpc_network.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http"] 
}




