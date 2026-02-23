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