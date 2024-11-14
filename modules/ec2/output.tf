output "sg" {
  value = aws_security_group.terraform_sg.id
}

output "name" {
  value = aws_security_group.terraform_sg.name
}

# Output the VPC ID

output "vpc_id" {
  value = data.aws_vpc.vpc.id
}

output "subnet_01" {
  value = data.aws_subnet.subnet_01.id
}

output "launch_template" {
  value = data.aws_launch_template.launch_template.id
}

output "eip" {
  value = aws_eip.my_elastic_ip.id
}