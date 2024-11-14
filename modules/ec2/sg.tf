# Define a security group to allow SSH and HTTP access
resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows SSH from any IP; adjust for better security
  }



  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows HTTP access from any IP
  }

  # Custom port 2000
  ingress {
    from_port   = 2000
    to_port     = 2000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust as needed for security
  }

  # Custom port 2001
  ingress {
    from_port   = 2001
    to_port     = 2001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust as needed for security
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"           = "terraform-sg"
    "owner"          = "Victor Orji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"
  }
}