# Specify the required Terraform version and AWS provider
terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS provider with the desired region
provider "aws" {
  region = "us-east-1"
}

# Create a VPC for the EKS cluster
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "voting-app-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
}

# Create the EKS cluster and node group
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.0"

  cluster_name    = "voting-app-harness"
  cluster_version = "1.27"

  # Use the VPC and subnets created earlier
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets

  # Define the node group equivalent to 'linux-nodes'
  node_groups = {
    linux_nodes = {
      desired_capacity = 2
      min_capacity     = 2
      max_capacity     = 2
      instance_types   = ["t2.xlarge"]
      ami_type         = "AL2_x86_64"  # Amazon Linux 2 AMI
    }
  }
}
