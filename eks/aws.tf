# `aws.tf` contains the shared config for the aws provider and shared AWS variables that both the VPC module and EKS module need
variable "region" {
  default     = "us-east-2"
  description = "AWS region"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

# `suffix` is a random string to use as an identifier for the eks cluster
resource "random_string" "suffix" {
  length  = 8
  special = false
}

# `cluster_name` is the eks cluster name a local variable for the cluster name
locals {
  cluster_name = "example-eks-${random_string.suffix.result}"
}

# `available` is a data set of available zone names
data "aws_availability_zones" "available" {}

# outputs
output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}