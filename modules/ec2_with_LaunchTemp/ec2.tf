# Create an EC2 instance
resource "aws_instance" "my_ec2_instance" {
  #ami           = data.aws_ami.amazon_linux_2022.id
  #instance_type = var.instance_type 

  vpc_security_group_ids = [aws_security_group.terraform_sg.id]

  root_block_device {
    volume_size = var.root_volume
    volume_type = "gp3"

  }
  launch_template {
    id      = data.aws_launch_template.launch_template.id
    version = "$Latest"
  }
  key_name = var.key_name

  # Tags to identify the instance
  tags = merge(var.tags, {
    Name = format("%s-%s-%s", var.tags["environment"], var.tags["project"], var.resource_type)
  })
}