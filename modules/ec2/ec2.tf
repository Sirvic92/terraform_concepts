# Create an EC2 instance
resource "aws_instance" "my_ec2_instance" {
  #ami           = "ami-063d43db0594b521b" # Amazon Linux 2 AMI ID; update based on your region
  #instance_type = "t2.micro"

  # Attach the security group to the instance
  vpc_security_group_ids = [aws_security_group.terraform_sg.id]

  #subnet_id = data.aws_subnet.subnet_01.id
  root_block_device {
    volume_size = 30
    volume_type = "gp3"

  }
  launch_template {

    id      = data.aws_launch_template.launch_template.id
    version = "$Latest"
  }

  # Define a key pair (make sure to specify an existing key name or create one in AWS)
  key_name = "window-pair" # Replace with your actual key pair name

  # Tags to identify the instance
  tags = merge(var.tags, {
    "Name" = "apache-web_1"

  })
}