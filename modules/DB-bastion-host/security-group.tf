resource "aws_security_group" "db_bastion_host" {
  name        = format("%s-%s-%s-db-bastion-host", var.tags["environment"], var.tags["project"], var.tags["owner"])
  description = "Security group for the DB bastion host"
  vpc_id      = var.vpc_id

  # Allow SSH access from any IP (for learning or testing purposes)
  ingress {
    description = "Allow SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Unrestricted access from any IP
  }

  # Allow the bastion to communicate with the RDS database over port 5432 (PostgreSQL)
  ingress {
    description = "Allow communication to RDS"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    # Unrestricted access to RDS (you can modify this to limit to specific security groups)
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound traffic for accessing pgAdmin on port 3035 (unrestricted access)
  ingress {
    description = "Allow access to pgAdmin (Port 3035)"
    from_port   = 3035
    to_port     = 3035
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Unrestricted access from any IP
  }

  # Outbound traffic allowed by default
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = format("%s-%s-%s-db-bastion-host", var.tags["environment"], var.tags["project"], var.tags["owner"])
  })
}
