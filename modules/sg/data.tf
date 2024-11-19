# Fetch all VPCs and filter for the default one
data "aws_vpcs" "all" {}

data "aws_vpc" "default" {
  filter {
    name   = "isDefault"
    values = ["true"]
  }
}

