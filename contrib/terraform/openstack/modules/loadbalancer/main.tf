resource "openstack_networking_port_v2" "lb_port" {
  network_id = var.network_id
  fixed_ip {
    subnet_id = var.subnet_id
  }
  admin_state_up = "true"
}

resource "openstack_networking_floatingip_associate_v2" "lb_fip" {
  floating_ip = var.lb_fip
  port_id     = openstack_networking_port_v2.lb_port.id
}

resource "openstack_lb_loadbalancer_v2" "k8s_lb" {
  name = var.cluster_name
  vip_subnet_id = var.subnet_id
  vip_network_id = var.network_id
  vip_port_id = openstack_networking_port_v2.lb_port.id
}

resource "openstack_lb_listener_v2" "k8s-control-plane" {
  protocol        = "HTTPS"
  protocol_port   = 6443
  loadbalancer_id = openstack_lb_loadbalancer_v2.k8s_lb.id
}

# Create pool
resource "openstack_lb_pool_v2" "k8s_control_plane" {
  name        = "kubernetes_control_plane"
  protocol    = "TCP"
  lb_method   = "ROUND_ROBIN"
  listener_id = openstack_lb_listener_v2.k8s-control-plane.id
}

# Add member to pool
resource "openstack_lb_member_v2" "k8s_masters" {
  count = length(var.k8s_masters)
  address       = element(var.k8s_masters, count.index)
  protocol_port = 6443
  pool_id       = openstack_lb_pool_v2.k8s_control_plane.id
  subnet_id     = var.subnet_id
}

resource "openstack_lb_listener_v2" "k8s_bastion" {
  protocol        = "TCP"
  protocol_port   = 22
  loadbalancer_id = openstack_lb_loadbalancer_v2.k8s_lb.id
}

# Create pool
resource "openstack_lb_pool_v2" "bastion" {
  name        = "kubernetes_bastion"
  protocol    = "TCP"
  lb_method   = "SOURCE_IP"
  listener_id = openstack_lb_listener_v2.k8s_bastion.id
}

# Add member to pool
resource "openstack_lb_member_v2" "k8s_bastion" {
  address       = var.bastion_address
  protocol_port = 22
  pool_id       = openstack_lb_pool_v2.bastion.id
  subnet_id     = var.subnet_id
}