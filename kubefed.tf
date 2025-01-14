# This block installs kubefed, a tool to manage multiple Kubernetes clusters
resource "null_resource" "install_kubefed" {
  provisioner "local-exec" {
    command = <<EOT
    kubectl apply -f https://github.com/kubernetes-sigs/kubefed/releases/download/v0.1.0/kubefed.yaml
    EOT
  }
}

# This block joins the Azure Kubernetes cluster to the federation
resource "null_resource" "join_azure_cluster" {
  provisioner "local-exec" {
    command = <<EOT
    kubefedctl join azure-cluster --cluster-context=azure-context --host-cluster-context=aws-context --v=2
    EOT
  }

  # This ensures that kubefed is installed before joining the Azure cluster
  depends_on = [null_resource.install_kubefed]
}

# This block joins the Alibaba Kubernetes cluster to the federation
resource "null_resource" "join_alibaba_cluster" {
  provisioner "local-exec" {
    command = <<EOT
    kubefedctl join alibaba-cluster --cluster-context=alibaba-context --host-cluster-context=aws-context --v=2
    EOT
  }

  # This ensures that kubefed is installed before joining the Alibaba cluster
  depends_on = [null_resource.install_kubefed]
}