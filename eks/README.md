# `outputs.tf` defines the output configuration.

This is implemented based off of the AWS EKS tutorial available on the [tutorials](https://learn.hashicorp.com/tutorials/terraform/eks?in=terraform/kubernetes) section of the Terraform website.

1. `vpc.tf` provisions a VPC, subnets and availability zones using the [AWS VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/2.32.0). A new VPC is created for this tutorial so it doesn't impact your existing cloud environment and resources.

2. `security-groups.tf` provisions the security groups used by the EKS cluster.

3. `eks-cluster.tf` provisions all the resources (AutoScaling Groups, etc...) required to set up an EKS cluster in the private subnets and bastion servers to access the cluster using the [AWS EKS Module](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/11.0.0).

4. `aws.tf` configures the AWS provider and shared variables that both EKS and VPC use.

5. `terraform.tf` sets the Terraform version to at least 0.12. It also sets versions for the providers used in this sample.

6. `variables.tf` defines the variables that can be passed in to the terraform config

7. `kubernetes.tf` uses the Kubernettes Provider access to provide access the EKS cluster
