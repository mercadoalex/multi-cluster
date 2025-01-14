# This block tells Terraform to use the Alibaba Cloud provider and set the region to the value of the variable
provider "alicloud" {
  region = var.alibaba_region  # Use the variable for the region
}

# This block creates a managed Kubernetes cluster in Alibaba Cloud
resource "alicloud_cs_managed_kubernetes" "example" {
  name_prefix = "example-cluster"  # Prefix for the name of the Kubernetes cluster
  vswitch_ids = [alicloud_vswitch.eks_vswitch.id]  # List of VSwitch IDs where the cluster will be created
  new_nat_gateway = true  # Create a new NAT gateway for the cluster
}

# This block creates a node pool for the Kubernetes cluster
resource "alicloud_cs_kubernetes_node_pool" "example" {
  cluster_id = alicloud_cs_managed_kubernetes.example.id  # The ID of the Kubernetes cluster
  name = "example-node-pool"  # Name of the node pool
  vswitch_ids = [alicloud_vswitch.eks_vswitch.id]  # List of VSwitch IDs where the node pool will be created
  instance_types = ["ecs.c6.large"]  # Type of instances (computers) for the worker nodes
  node_count = 1  # Number of worker nodes in the node pool
}

# This block creates a VSwitch in the VPC
resource "alicloud_vswitch" "eks_vswitch" {
  vpc_id = alicloud_vpc.eks_vpc.id  # The VPC where the VSwitch will be created
  cidr_block = "172.16.0.0/24"  # The IP range for the VSwitch
  availability_zone = "us-west-1a"  # The availability zone for the VSwitch
}

# This block creates a VPC (Virtual Private Cloud)
resource "alicloud_vpc" "eks_vpc" {
  cidr_block = "172.16.0.0/16"  # The IP range for the VPC
}