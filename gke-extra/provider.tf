provider "google" {
  # credentials = file("${var.credentials}")

  project = var.gcp_project
  region  = var.region
  zone    = var.zone
}

provider "helm" {
  kubernetes {
    config_path = "C:/Users/keerthik.shenoy/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "C:/Users/keerthik.shenoy/.kube/config"
}