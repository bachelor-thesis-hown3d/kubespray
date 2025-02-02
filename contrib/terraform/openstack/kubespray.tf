module "network" {
  source = "./modules/network"

  external_network_name       = var.external_network_name
  subnet_cidr        = var.subnet_cidr
  cluster_name       = var.cluster_name
  dns_nameservers    = var.dns_nameservers
  network_dns_domain = var.network_dns_domain
  use_neutron        = var.use_neutron
  router_id          = var.router_id
}

module "ips" {
  source = "./modules/ips"

  number_of_k8s_masters         = var.number_of_k8s_masters
  number_of_k8s_masters_no_etcd = var.number_of_k8s_masters_no_etcd
  number_of_k8s_nodes           = var.number_of_k8s_nodes
  floatingip_pool               = var.floatingip_pool
  number_of_bastions            = var.number_of_bastions
  k8s_nodes                     = var.k8s_nodes
  k8s_master_fips               = var.k8s_master_fips
  bastion_fips                  = var.bastion_fips
  depends_on = [
    module.network
  ]
}

module "compute" {
  source = "./modules/compute"

  cluster_name                                 = var.cluster_name
  az_list                                      = var.az_list
  az_list_node                                 = var.az_list_node
  number_of_k8s_masters                        = var.number_of_k8s_masters
  number_of_k8s_masters_no_etcd                = var.number_of_k8s_masters_no_etcd
  number_of_etcd                               = var.number_of_etcd
  number_of_k8s_masters_no_floating_ip         = var.number_of_k8s_masters_no_floating_ip
  number_of_k8s_masters_no_floating_ip_no_etcd = var.number_of_k8s_masters_no_floating_ip_no_etcd
  number_of_k8s_nodes                          = var.number_of_k8s_nodes
  number_of_bastions                           = var.number_of_bastions
  number_of_k8s_nodes_no_floating_ip           = var.number_of_k8s_nodes_no_floating_ip
  number_of_gfs_nodes_no_floating_ip           = var.number_of_gfs_nodes_no_floating_ip
  k8s_nodes                                    = var.k8s_nodes
  bastion_root_volume_size_in_gb               = var.bastion_root_volume_size_in_gb
  etcd_root_volume_size_in_gb                  = var.etcd_root_volume_size_in_gb
  master_root_volume_size_in_gb                = var.master_root_volume_size_in_gb
  node_root_volume_size_in_gb                  = var.node_root_volume_size_in_gb
  gfs_root_volume_size_in_gb                   = var.gfs_root_volume_size_in_gb
  gfs_volume_size_in_gb                        = var.gfs_volume_size_in_gb
  master_volume_type                           = var.master_volume_type
  public_key_path                              = var.public_key_path
  image                                        = var.image
  image_uuid                                   = var.image_uuid
  image_gfs                                    = var.image_gfs
  image_master                                 = var.image_master
  image_master_uuid                            = var.image_master_uuid
  image_gfs_uuid                               = var.image_gfs_uuid
  ssh_user                                     = var.ssh_user
  ssh_user_gfs                                 = var.ssh_user_gfs
flavor_k8s_master                            = var.flavor_k8s_master
  flavor_k8s_node                              = var.flavor_k8s_node
    flavor_bastion                               = var.flavor_bastion
  flavor_etcd                                  = var.flavor_etcd
  flavor_gfs_node                              = var.flavor_gfs_node
  k8s_master_fips                              = module.ips.k8s_master_fips
  k8s_master_no_etcd_fips                      = module.ips.k8s_master_no_etcd_fips
  k8s_node_fips                                = module.ips.k8s_node_fips
  k8s_nodes_fips                               = module.ips.k8s_nodes_fips
  bastion_fips = [module.ips.k8s_lb_fip]
  bastion_allowed_remote_ips                   = var.bastion_allowed_remote_ips
  master_allowed_remote_ips                    = var.master_allowed_remote_ips
  k8s_allowed_remote_ips                       = var.k8s_allowed_remote_ips
  k8s_allowed_egress_ips                       = var.k8s_allowed_egress_ips
  supplementary_master_groups                  = var.supplementary_master_groups
  supplementary_node_groups                    = var.supplementary_node_groups
  master_allowed_ports                         = var.master_allowed_ports
  worker_allowed_ports                         = var.worker_allowed_ports
  wait_for_floatingip                          = var.wait_for_floatingip
  use_access_ip                                = var.use_access_ip
  master_server_group_policy                   = var.master_server_group_policy
  node_server_group_policy                     = var.node_server_group_policy
  etcd_server_group_policy                     = var.etcd_server_group_policy
  extra_sec_groups                             = var.extra_sec_groups
  extra_sec_groups_name                        = var.extra_sec_groups_name
  group_vars_path                              = var.group_vars_path
  network_name = one(module.network.network_name)

  network_id = module.network.router_id
  depends_on = [
    module.network
  ]
}

module "lb" {
  source = "./modules/loadbalancer"
  cluster_name = var.cluster_name
  network_id = one(module.network.network_id) 
  k8s_masters = concat(module.compute.k8s_no_floating_ip_master_addresses, module.compute.k8s_master_addresses)
  bastion_address = one(module.compute.k8s_bastion_address)
  lb_fip = module.ips.k8s_lb_fip
  subnet_id = module.network.subnet_id
}

output "lb_fip" {
  value = module.ips.k8s_lb_fip
}

output "private_subnet_id" {
  value = module.network.subnet_id
}

output "router_id" {
  value = module.network.router_id
}

output "k8s_master_internal_ips" {
  value = concat(module.compute.k8s_no_floating_ip_master_addresses, module.compute.k8s_master_addresses)
}

output "k8s_master_fips" {
  value = concat(module.ips.k8s_master_fips, module.ips.k8s_master_no_etcd_fips)
}

output "k8s_node_fips" {
  value = var.number_of_k8s_nodes > 0 ? module.ips.k8s_node_fips : [for key, value in module.ips.k8s_nodes_fips : value.address]
}

output "bastion_fips" {
  value = module.ips.bastion_fips
}
