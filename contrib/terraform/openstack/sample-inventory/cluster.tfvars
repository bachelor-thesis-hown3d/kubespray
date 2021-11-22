# your Kubernetes cluster name here
cluster_name = "i-didnt-read-the-docs"

# list of availability zones available in your OpenStack cluster
#az_list = ["nova"]

# SSH key to use for access to nodes
public_key_path = "~/.ssh/id_rsa.pub"

# image to use for bastion, masters, standalone etcd instances, and nodes
image = "Ubuntu 20.04"

# user on the node (ex. core on Container Linux, ubuntu on Ubuntu, etc.)
ssh_user = "ubuntu"

# 0|1 bastion nodes
number_of_bastions = 1

#flavor_bastion = "<UUID>"

# standalone etcds
number_of_etcd = 0

# masters
number_of_k8s_masters = 

number_of_k8s_masters_no_etcd = 0

number_of_k8s_masters_no_floating_ip = 1

number_of_k8s_masters_no_floating_ip_no_etcd = 0

cpus_k8s_master = 2
memory_k8s_master = 2048

# nodes
number_of_k8s_nodes = 0

number_of_k8s_nodes_no_floating_ip = 3

cpus_k8s_node = 2
memory_k8s_node = 2048

# GlusterFS
# either 0 or more than one
#number_of_gfs_nodes_no_floating_ip = 0
#gfs_volume_size_in_gb = 150
# Container Linux does not support GlusterFS
#image_gfs = "<image name>"
# May be different from other nodes
#ssh_user_gfs = "ubuntu"
#flavor_gfs_node = "<UUID>"

# networking
network_name = ""

external_network_name = "ext01"

subnet_cidr = "10.0.0.0/24"

floatingip_pool = "ext01"

bastion_allowed_remote_ips = ["0.0.0.0/0"]