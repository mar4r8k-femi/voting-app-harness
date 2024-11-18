resource "null_resource" "eksctl_cluster" {
  provisioner "local-exec" {
    command = <<EOT
    curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /usr/local/bin
    eksctl create cluster \
      --name voting-app-harness \
      --region us-east-1 \
      --nodegroup-name linux-nodes \
      --node-type t2.xlarge \
      --nodes 2
    EOT
  }
}
