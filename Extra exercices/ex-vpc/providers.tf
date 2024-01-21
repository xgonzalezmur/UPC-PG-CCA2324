terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 3.2"
    }
  }

  required_version = ">= 1.1.5"
}

provider "aws" {
  region = var.region
}
