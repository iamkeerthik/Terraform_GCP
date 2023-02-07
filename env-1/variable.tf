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
