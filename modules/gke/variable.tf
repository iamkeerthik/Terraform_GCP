
variable "name" {
  type = string
}

variable "gcp_project" {
  description = "Project Id of the GCP account"
  type        = string
}

variable "gke_node_type" {
  description = "machine type for gke node pool"
  type = string
}

variable "node_count" {
  description = "no of nodes in nodepool"
  type =  number
}
variable "min_node_count" {
  description = "min no of nodes in nodepool"
  type =  number
}
variable "max_node_count" {
  description = "max no of nodes in nodepool"
  type =  number
}
# variable "cluster_name" {
#   description = "Name of the GKE cluster"
#   type        = string
# }

# variable "location" {
#   description = "Location of the GKE cluster"
#   type        = string
# }

# variable "initial_node_count" {
#   description = "Initial number of nodes in the GKE cluster"
#   type        = number
# }

# variable "min_master_version" {
#   description = "The desired minimum version of the master"
#   type        = string
# }

# variable "logging_service" {
#   description = "The logging service that the cluster should write logs to"
#   type        = string
# }

# variable "monitoring_service" {
#   description = "The monitoring service that the cluster should write metrics to"
#   type        = string
# }

# variable "cluster_name" {
#   description = "Name of the GKE cluster"
#   type        = string
# }

# variable "location" {
#   description = "Location of the GKE cluster"
#   type        = string
# }

# variable "initial_node_count" {
#   description = "Initial number of nodes in the GKE cluster"
#   type        = number
# }

# variable "min_master_version" {
#   description = "The desired minimum version of the master"
#   type        = string
# }

# variable "logging_service" {
#   description = "The logging service that the cluster should write logs to"
#   type        = string
# }

# variable "monitoring_service" {
#   description = "The monitoring service that the cluster should write metrics to"
#   type        = string
# }

