variable "external_network_name" {
  type = string
  description = "Name of the external network"
}

variable "network_dns_domain" {}

variable "cluster_name" {}

variable "dns_nameservers" {
  type = list
}

variable "subnet_cidr" {}

variable "use_neutron" {}

variable "router_id" {}
