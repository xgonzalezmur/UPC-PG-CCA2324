module "private_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.prefix}-private-sg"
  description = "Security group for apps within private VPC"
  vpc_id      = module.vpc_private.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp"]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Xavi González"
    Project     = "CCA2324"
  }
}

module "test_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.prefix}-test-sg"
  description = "Security group for the testinc ec2 within egress VPC"
  vpc_id      = module.vpc_egress.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp"]

  egress_with_cidr_blocks = [
    {
      rule        = "all-all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}
