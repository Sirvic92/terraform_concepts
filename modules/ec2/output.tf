

# Output the VPC ID

output "vpc_id" {
  value = data.aws_vpc.default.id
}


output "eip" {
  value = aws_eip.my_elastic_ip.id
}