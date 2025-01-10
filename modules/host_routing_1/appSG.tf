resource "aws_security_group" "app_security_group" {
  name        = format("%s-%s-%s-appsg", var.tags["environment"], var.tags["project"], var.tags["owner"])
  description = "Security group for application instances"
  vpc_id      = var.vpc_id
  # Allow inbound traffic from ALB security group
  ingress {
    description = "Allow traffic from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    #cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.alb_security_group.id]
  }

  # Allow outbound traffic (e.g., application can reach external services or databases)
  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = var.tags
}

