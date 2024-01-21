module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name           = "${var.prefix}-key-pair"
  create_private_key = true
}