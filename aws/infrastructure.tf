resource "null_resource" "eksctl_cluster" {
  provisioner "local-exec" {
    command = <<EOT
    eksctl create cluster \
    --name voting-app-harness \
    --region us-east-1 \
    --nodegroup-name linux-nodes \
    --node-type t2.xlarge \
    --nodes 2
    EOT
  }
}
