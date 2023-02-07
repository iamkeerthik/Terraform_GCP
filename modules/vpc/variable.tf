variable "name" {
  type = string
}

variable "private_subnet_cidr_range" {
  description = "Subnet CIDR IP range"
}

variable "public_subnet_cidr_range" {
  description = "Subnet CIDR IP range"
}

variable "region" {
  description = "Region in which the resources will create"
  type        = string
}
# variable "subnet_region" {
#   type = string
# }

# variable "firewall_name" {
#   type = string
# }

# variable "firewall_protocol" {
#   type = string
# }

# variable "firewall_port" {
#   type = string
# }

# variable "firewall_src_range" {
#   type = string
# }
