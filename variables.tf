# Project naming
variable "project" {
  type    = string
  default = "aws-infra-cloud"
}

# EC2 instance type
variable "instance_type" {
  type    = string
  default = "t2.micro"
}

# EC2 key pair (set to null, no SSH needed for this demo)
variable "key_name" {
  type    = string
  default = null
}

# Region
variable "region" {
  type    = string
  default = "us-east-1"
}

# Security group rules
variable "allowed_ssh_cidr" {
  type    = string
  default = "0.0.0.0/0"
}
