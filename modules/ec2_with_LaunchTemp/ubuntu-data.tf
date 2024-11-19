data "aws_ami" "ubuntu_2022" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]

  }

  filter {
    name   = "owner-id"
    values = ["099720109477"] # Canonical's AWS Account ID
  }

  # Specify the region if necessary
  owners = ["099720109477"] # Canonical's AWS Account ID
}

output "ubuntu_2022_ami_id" {
  value = data.aws_ami.ubuntu_2022.id
}
