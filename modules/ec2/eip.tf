# Create an Elastic IP
resource "aws_eip" "my_elastic_ip" {
  vpc = true
  tags = merge(var.tags, {
    "Name"     = "elastic_ip"

  })


}

# Associate the Elastic IP with an instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.my_ec2_instance.id
  allocation_id = aws_eip.my_elastic_ip.id
}
