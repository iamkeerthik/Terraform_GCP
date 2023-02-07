
module "vpc" {
  source            = "../modules/vpc"
  name              = var.name
#   gcp_project       = var.gcp_project
  region            = var.region
  private_subnet_cidr_range = var.private_subnet_cidr_range
  public_subnet_cidr_range = var.public_subnet_cidr_range

}

module "compute-engine" {
    source = "../modules/compute-engine"
    gcp_project = var.gcp_project
    name = var.name
    instance_type = var.instance_type
    instance_zone = var.instance_zone
}
