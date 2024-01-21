module "ec2_isolated" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.prefix}-isolated-ec2"

  ami                    = "ami-079db87dc4c10ac91"
  instance_type          = "t2.micro"
  key_name               = module.key_pair.key_pair_name
  monitoring             = true
  vpc_security_group_ids = [module.private_sg.security_group_id]
  subnet_id              = module.vpc_private.intra_subnets[0]

  user_data = filebase64("./scripts/ec2-userdata.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Xavi González"
    Project     = "CCA2324"
  }
}

module "ec2-test" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.prefix}-test-ec2"

  ami                         = "ami-079db87dc4c10ac91"
  instance_type               = "t2.micro"
  key_name                    = module.key_pair.key_pair_name
  monitoring                  = true
  vpc_security_group_ids      = [module.test_sg.security_group_id]
  subnet_id                   = module.vpc_egress.public_subnets[0]
  associate_public_ip_address = true
}
