# This block tells Terraform to use the AWS provider and set the region to the value of the variable
provider "aws" {
  region = var.aws_region # Use the variable for the region
}

# This block creates an Amazon EKS (Elastic Kubernetes Service) cluster
resource "aws_eks_cluster" "example" {
  name     = var.cluster_name                  # Name of the EKS cluster
  role_arn = aws_iam_role.eks_cluster_role.arn # The IAM role that EKS will use

  # VPC (Virtual Private Cloud) configuration for the EKS cluster
  vpc_config {
    subnet_ids = aws_subnet.eks_subnet[*].id # List of subnet IDs where the EKS cluster will be created
  }
}

# This block creates an IAM (Identity and Access Management) role for the EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-role" # More meaningful name for the IAM role

  # Policy that allows EKS to assume this role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole" # Allow the action to assume the role
        Effect = "Allow"          # Allow this action
        Principal = {
          Service = "eks.amazonaws.com" # The service that can assume this role (EKS)
        }
      },
    ]
  })
}

# This block creates two subnets in the VPC
resource "aws_subnet" "eks_subnet" {
  count      = 2                                                      # Create 2 subnets
  vpc_id     = aws_vpc.eks_vpc.id                                     # The VPC where the subnets will be created
  cidr_block = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 8, count.index) # The IP range for the subnets
}

# This block creates a VPC (Virtual Private Cloud)
resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16" # The IP range for the VPC
}