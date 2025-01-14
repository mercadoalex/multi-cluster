# Define a variable for the AWS region
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-2" # Default region
}

# Define a variable for the Azure location
variable "azure_location" {
  description = "The Azure location to deploy resources in"
  type        = string
  default     = "West US" # Default location
}

# Define a variable for the Alibaba region
variable "alibaba_region" {
  description = "The Alibaba Cloud region to deploy resources in"
  type        = string
  default     = "us-west-1" # Default region closer to Mexico
}

# Define a variable for the cluster name
variable "cluster_name" {
  description = "The name of the Kubernetes cluster"
  type        = string
  default     = "multicloud-cluster" # Default cluster name
}