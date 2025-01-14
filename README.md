# Multi-Cloud Kubernetes Cluster with Terraform

This project provisions Kubernetes clusters across multiple cloud providers (AWS, Azure, and Alibaba Cloud) using Terraform. It also sets up Kubernetes Federation to manage these clusters as a single entity.

## Project Structure

- `aws.tf`: Terraform configuration for provisioning an EKS cluster in AWS.
- `azure.tf`: Terraform configuration for provisioning an AKS cluster in Azure.
- `alibaba.tf`: Terraform configuration for provisioning a Kubernetes cluster in Alibaba Cloud.
- `kubefed.tf`: Terraform configuration for installing `kubefed` and joining the Azure and Alibaba clusters to the federation.
- `vars.tf`: Terraform variables file for storing common configuration values.
- `.gitignore`: Git ignore file to exclude sensitive and unnecessary files from version control.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) installed on your machine.
- AWS, Azure, and Alibaba Cloud accounts with appropriate permissions.
- `kubectl` and `kubefedctl` installed and configured.

## Setup

1. **Clone the repository:**

   ```sh
   git clone <repository-url>
   cd <repository-directory>