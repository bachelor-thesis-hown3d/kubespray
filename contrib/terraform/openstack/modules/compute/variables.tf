variable "cluster_name" {}

variable "az_list" {
  type = list(string)
}

variable "az_list_node" {
  type = list(string)
}

variable "cpus_k8s_node" {
  type = number
  description = "vCPUs used for the node flavor image"
  default = 2
} 
variable "memory_k8s_node" {
  type = number
  description = "Memory in Bytes for the node flavor image"
  default = 2048
}

variable "disk_k8s_node" {
  type = number
  description = "Disk Size in Gigabytes for the master flavor image"
  default = 20
}

variable "cpus_k8s_master" {
  type = number
  description = "vCPUs used for the master flavor image"
  default = 2
} 
variable "memory_k8s_master" {
  type = number
  description = "Memory in Bytes for the master flavor image"
  default = 2048
}

variable "disk_k8s_master" {
  type = number
  description = "Disk Size in GigaBytes for the master flavor image"
  default = 20
}


variable "number_of_k8s_masters" {}

variable "number_of_k8s_masters_no_etcd" {}

variable "number_of_etcd" {}

variable "number_of_k8s_masters_no_floating_ip" {}

variable "number_of_k8s_masters_no_floating_ip_no_etcd" {}

variable "number_of_k8s_nodes" {}

variable "number_of_k8s_nodes_no_floating_ip" {}

variable "number_of_bastions" {}

variable "number_of_gfs_nodes_no_floating_ip" {}

variable "bastion_root_volume_size_in_gb" {}

variable "etcd_root_volume_size_in_gb" {}

variable "master_root_volume_size_in_gb" {}

variable "node_root_volume_size_in_gb" {}

variable "gfs_root_volume_size_in_gb" {}

variable "gfs_volume_size_in_gb" {}

variable "master_volume_type" {}

variable "public_key_path" {}

variable "image" {}

variable "image_gfs" {}

variable "ssh_user" {}

variable "ssh_user_gfs" {}

variable "flavor_etcd" {}

variable "flavor_gfs_node" {}

variable "network_name" {}

variable "network_id" {
  default = ""
}

variable "k8s_master_fips" {
  type = list
}

variable "k8s_master_no_etcd_fips" {
  type = list
}

variable "k8s_node_fips" {
  type = list
}

variable "k8s_nodes_fips" {
  type = map
}

variable "bastion_fips" {
  type = list
}

variable "bastion_allowed_remote_ips" {
  type = list
}

variable "master_allowed_remote_ips" {
  type = list
}

variable "k8s_allowed_remote_ips" {
  type = list
}

variable "k8s_allowed_egress_ips" {
  type = list
}

variable "k8s_nodes" {}

variable "wait_for_floatingip" {}

variable "supplementary_master_groups" {
  default = ""
}

variable "supplementary_node_groups" {
  default = ""
}

variable "master_allowed_ports" {
  type = list
}

variable "worker_allowed_ports" {
  type = list
}

variable "use_access_ip" {}

variable "master_server_group_policy" {
  type = string
}

variable "node_server_group_policy" {
  type = string
}

variable "etcd_server_group_policy" {
  type = string
}

variable "extra_sec_groups" {
  type = bool
}

variable "extra_sec_groups_name" {
  type = string
}

variable "image_uuid" {
  type = string
}

variable "image_gfs_uuid" {
  type = string
}

variable "image_master" {
  type = string
}

variable "image_master_uuid" {
  type = string
}

variable "group_vars_path" {
  type = string
}
