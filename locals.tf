locals {
  name_prefix = "${var.project}-main"
  tags = {
    Project   = var.project
    ManagedBy = "Terraform"
  }
}