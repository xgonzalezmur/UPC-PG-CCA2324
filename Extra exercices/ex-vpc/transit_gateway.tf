module "tgw" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "~> 2.0"

  name = "${var.prefix}-tgw"

  share_tgw = false

  vpc_attachments = {
    vpc-egress = {
      vpc_id      = module.vpc_egress.vpc_id
      subnet_ids  = module.vpc_egress.public_subnets
      dns_support = true

      tgw_routes = [
        {
          destination_cidr_block = module.vpc_private.vpc_cidr_block
        }
      ]
    },
    vpc-private = {
      vpc_id      = module.vpc_private.vpc_id
      subnet_ids  = module.vpc_private.intra_subnets
      dns_support = true

      tgw_routes = [
        {
          destination_cidr_block = module.vpc_egress.vpc_cidr_block
        }
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

resource "aws_route" "route_from_egress_to_private" {
  for_each = { for k, v in module.vpc_egress.public_route_table_ids : k => v }

  route_table_id         = each.value
  destination_cidr_block = module.vpc_private.vpc_cidr_block
  transit_gateway_id     = module.tgw.ec2_transit_gateway_id
}

resource "aws_route" "route_from_private_to_egress" {
  for_each = { for k, v in module.vpc_private.intra_route_table_ids : k => v }

  route_table_id         = each.value
  destination_cidr_block = module.vpc_egress.vpc_cidr_block
  transit_gateway_id     = module.tgw.ec2_transit_gateway_id
}