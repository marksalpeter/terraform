# `security-groups.tf` provisions the security groups used by the EKS cluster.

resource "aws_security_group" "example_eks_workers" {
  name_prefix = "example_eks_workers"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}
