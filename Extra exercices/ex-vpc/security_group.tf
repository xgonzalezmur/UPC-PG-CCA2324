module "web_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.prefix}-web-sg"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc-egress.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "http-8080-tcp", "https-443-tcp", "all-icmp"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Xavi González"
    Project     = "CCA2324"
  }
}
