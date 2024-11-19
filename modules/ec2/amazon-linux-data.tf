data "aws_ami" "amazon_linux_2022" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "owner-id"
    values = ["137112412989"] # Amazon's AWS Account ID
  }

  # Restrict to official Amazon-owned AMIs
  owners = ["137112412989"]
}

output "amazon_linux_2022_ami_id" {
  value = data.aws_ami.amazon_linux_2022.id
}
