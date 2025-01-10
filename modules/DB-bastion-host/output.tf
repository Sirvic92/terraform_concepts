

# Output the VPC ID

# output "vpc_id" {
#   value = data.aws_vpc.default.id
# }


# output "eip" {
#   value = aws_eip.my_elastic_ip.id
# }

output "amazon_linux_2022_ami_id" {
  value = data.aws_ami.amazon_linux_2022.id
}
