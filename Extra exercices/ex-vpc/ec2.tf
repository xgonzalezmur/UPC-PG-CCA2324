module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  ami                    = "ami-079db87dc4c10ac91"
  instance_type          = "t2.micro"
  key_name               = "user1"
  monitoring             = true
  vpc_security_group_ids = [module.web_sg.security_group_id]
  subnet_id              = module.vpc-private.private_subnets[0].subnet_id

  user_data = filebase64("./scripts/ec2-userdata.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
    Owner       = "Xavi González"
    Project     = "CCA2324"
  }
}
