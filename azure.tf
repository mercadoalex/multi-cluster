provider "azurerm" {
  features {}
}

# This block creates a Kubernetes cluster in Azure
resource "azurerm_kubernetes_cluster" "example" {
  name                = var.cluster_name                    # Name of the Kubernetes cluster
  location            = var.azure_location                  # Location where the cluster will be created
  resource_group_name = azurerm_resource_group.example.name # The resource group where the cluster will be created
  dns_prefix          = "exampleaks"                        # Prefix for the DNS name of the cluster

  # This block defines the default node pool for the cluster
  default_node_pool {
    name       = "default"         # Name of the node pool
    node_count = 1                 # Number of nodes (computers) in the pool
    vm_size    = "Standard_DS2_v2" # Size of the virtual machines for the nodes
  }

  # This block sets the identity type for the cluster
  identity {
    type = "SystemAssigned" # The identity type is system-assigned
  }
}

# This block creates a resource group in Azure
resource "azurerm_resource_group" "example" {
  name     = "example-resources" # Name of the resource group
  location = var.azure_location  # Location where the resource group will be created
}