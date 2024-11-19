output "default_vpc_id" {
  value = data.aws_vpc.default.id
}

output "security_group_id" {
  value = aws_security_group.terraform_sg.id
}

output "security_group_name" {
  value = aws_security_group.terraform_sg.name
}