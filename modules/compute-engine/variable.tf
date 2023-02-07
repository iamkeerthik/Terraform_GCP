
variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_zone" {
  type = string
}

variable "gcp_project" {
  description = "Project Id of the GCP account"
  type        = string
}

# variable "subnet_self_link" {
#   type = string
# }

# variable "instance_boot_disk_size" {
#   type = string
# }

# variable "instance_boot_disk_type" {
#   type = string
# }

# variable "instance_tags" {
#   type = list(string)
# }

# variable "instance_service_account" {
#   type = string
# }

# variable "instance_metadata" {
#   type = map(string)
# }

# variable "instance_labels" {
#   type = map(string)
# }

# variable "instance_preemptible" {
#   type = bool
# }

# variable "instance_automatic_restart" {
#   type = bool
# }
