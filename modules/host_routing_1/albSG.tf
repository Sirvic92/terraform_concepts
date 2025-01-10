resource "aws_security_group" "alb_security_group" {
  name        = format("%s-%s-%s-albsg", var.tags["environment"], var.tags["project"], var.tags["owner"])
  description = "Security group for ALB"
  vpc_id      = var.vpc_id

  # Allow inbound traffic for HTTP (port 80)
  ingress {
    description      = "Allow HTTP traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow inbound traffic for HTTPS (port 443)
  ingress {
    description      = "Allow HTTPS traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

 tags = var.tags
}

output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}
