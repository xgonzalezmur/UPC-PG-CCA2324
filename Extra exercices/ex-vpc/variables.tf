variable "prefix" {
  description = "Prefix of the name of the created resources"
  type        = string
  default     = "ex-vpc"
}

variable "region" {
  description = "The selected AWS region for the VPC"
  type        = string
  default     = "us-east-1"
}
