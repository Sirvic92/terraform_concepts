# Use a data source to fetch the VPC by tag
data "aws_vpc" "vpc" {
  # Filter by the specific tag
  filter {
    name   = "tag:Name"
    values = ["default"] # Replace with the actual tag value
  }
}

# data "aws_security_group" "sg" {
#   # Filter by the specific tag
#   filter {
#     name   = "tag:Name"
#     values = ["terraform-sg"] # Replace with the actual tag value
#   }
  
# }


data "aws_subnet" "subnet_01" {
  # Filter by the specific tag
  filter {
    name   = "tag:Name"
    values = ["default-01"] # Replace with the actual tag value
  }
}

data "aws_launch_template" "launch_template" {
  # Filter by the specific tag
  filter {
    name   = "tag:Name"
    values = ["linux-web"] # Replace with the actual tag value
  }
}

# data "aws_eip" "eip" {
#   # Filter by the specific tag
#   filter {
#     name   = "tag:Name"
#     values = ["elastic_ip"] # Replace with the actual tag value
#   }
# }
