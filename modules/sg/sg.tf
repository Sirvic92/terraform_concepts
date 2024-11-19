# Define a security group to allow specified inbound ports
resource "aws_security_group" "terraform_sg" {
  name        = var.sg_resource_name
  description = "Allow inbound traffic for specified ports"
  vpc_id      = data.aws_vpc.default.id

  # Iterate through the variable for inbound ports
  dynamic "ingress" {
    for_each = var.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # Adjust for better security
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    {
      Name = format("%s-%s-%s", var.tags["environment"], var.tags["project"], var.sg_resource_name)
    }
  )

}
