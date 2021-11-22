variable "subnet_id" {
  type = string
}

variable "network_id" {
  type = string
}

variable "k8s_masters" {
  type = list(string)
  description = "Addresses of the k8s masters"
}

variable "lb_fip" {
  type = string
  description = "Floating IP for the lb, must exist!"
}

variable "cluster_name" {
  type = string
}


variable "bastion_address" {
  type = string
}