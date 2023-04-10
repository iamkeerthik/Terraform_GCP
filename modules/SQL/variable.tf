variable "name" {
  type = string
}

variable "db_tier" {
  type = string
}
variable "gcp_project" {
  description = "Project Id of the GCP account"
  type        = string
}

variable "region" {
  description = "Region in which the resources will create"
  type        = string
}