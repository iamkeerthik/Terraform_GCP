
module "vpc" {
  source            = "../modules/vpc"
  name              = var.name
  gcp_project       = var.gcp_project
  region            = var.region
  private_subnet_cidr_range = var.private_subnet_cidr_range
  public_subnet_cidr_range = var.public_subnet_cidr_range

}

module "iam-service_account" {
  source = "../modules/iam-service-accounts"
  name = var.name
  gcp_project = var.gcp_project
  
}

module "compute-engine" {
    source = "../modules/compute-engine"
    depends_on = [
      module.iam-service_account
    ]
    gcp_project = var.gcp_project
    name = var.name
    instance_type = var.instance_type
    instance_zone = var.instance_zone
}

module "gke_cluster" {
  source = "../modules/gke"
  depends_on = [
    module.iam-service_account
  ]
  gcp_project = var.gcp_project
  name = var.name
  gke_node_type = var.gke_node_type
  node_count = var.node_count
  min_node_count = var.min_node_count
  max_node_count = var.max_node_count
}