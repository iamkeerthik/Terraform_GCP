variable "credentials" {
  description = "GCP Service Account Key Credentials"
}
variable "name" {
  description = "prefix in resources name"
  type        = string
}
variable "gcp_project" {
  description = "Project Id of the GCP account"
  type        = string
}
variable "region" {
  description = "Region in which the resources will create"
  type        = string
}
variable "zone" {
  description = "Zone in which the resources will create"
  type        = string
}


variable "private_subnet_cidr_range" {
  description = "Subnet CIDR IP range"
}

variable "public_subnet_cidr_range" {
  description = "Subnet CIDR IP range"
}

variable "instance_type" {
  type = string
}

variable "instance_zone" {
  type = string
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

#########Pub-Sub##########
variable "topics" {
  type        = list(string)
  description = "A list of Pub/Sub topic names to create"
}

variable "subscriptions" {
  type        = list(string)
  description = "A list of Pub/Sub subscription names to create"
}

variable "db_tier" {
  type = string
}