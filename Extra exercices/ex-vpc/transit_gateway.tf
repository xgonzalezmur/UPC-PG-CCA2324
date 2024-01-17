module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  name        = "${var.prefix}-tgw"

  enable_auto_accept_shared_attachments = true

  vpc_attachments = {
    vpc-egress = {
      vpc_id       = module.vpc-egress.vpc_id
      subnet_ids   = module.vpc-egress.private_subnets
      dns_support  = true

      tgw_routes = [
        {
          destination_cidr_block = "10.1.0.0/16"
        }/*,
        {
          blackhole = true
          destination_cidr_block = "10.0.0.0/16"
        }*/
      ]
    },
    vpc-private = {
      vpc_id       = module.vpc-private.vpc_id
      subnet_ids   = module.vpc-private.intra_subnets
      dns_support  = true

      tgw_routes = [
        {
          destination_cidr_block = "10.0.0.0/16"
        }/*,
        {
          blackhole = true
          destination_cidr_block = "10.0.0.0/16"
        }*/
      ]
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Xavi González"
    Project     = "CCA2324"
  }
}