
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
  depends_on = [
    module.vpc
  ]
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
    pluto_script  = file("pluto-userdata.ps1")
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
  region            = var.region
  location = var.location
}

# module "grafana" {
#   source = "../modules/gke-extra"
# }
module "pub-sub" {
  source = "../modules/pub-sub"
  depends_on = [
    module.vpc
  ]
  topics = var.topics
  subscriptions = var.subscriptions
}

module "sql" {
  source = "../modules/SQL"
  depends_on = [
    module.vpc
  ]
  name              = var.name
  gcp_project       = var.gcp_project
  region            = var.region
  db_tier = var.db_tier
}

module "monitoring" {
  source = "../modules/monitor"
  depends_on = [
    module.compute-engine,
    module.sql
  ]
  name = var.name
  instance_zone = var.instance_zone
  gcp_project =var.gcp_project
}