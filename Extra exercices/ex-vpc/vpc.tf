module "vpc-egress" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.prefix}-vpc-egress"
  cidr = "10.0.0.0/16"

  azs              = ["${var.region}a", "${var.region}b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.11.0/24", "10.0.12.0/24"]

  enable_vpn_gateway = true
  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Xavi González"
    Project     = "CCA2324"
  }

  igw_tags = {
    Name = "${var.prefix}-igw"
  }

  nat_gateway_tags = {
    Name = "${var.prefix}-natgw"
  }
}

module "vpc-private" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${var.prefix}-vpc-private"
  cidr = "10.1.0.0/16"

  azs           = ["${var.region}a"]
  intra_subnets = ["10.1.1.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Xavi González"
    Project     = "CCA2324"
  }
}