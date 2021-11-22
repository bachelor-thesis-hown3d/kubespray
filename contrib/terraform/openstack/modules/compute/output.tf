output "k8s_master_addresses" {
  value = openstack_compute_instance_v2.k8s_master.*.access_ip_v4
}
output "k8s_bastion_address" {
  value = openstack_compute_instance_v2.bastion.*.access_ip_v4
}

output "k8s_no_floating_ip_masters" {
  value = openstack_compute_instance_v2.k8s_master_no_floating_ip.*.access_ip_v4
}