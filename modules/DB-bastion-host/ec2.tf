resource "aws_instance" "db_bastion_host" {
  ami                    = data.aws_ami.amazon_linux_2022.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.db_bastion_host.id]  # Attach the DB-bastion-host security group here
  subnet_id              = var.subnet_id  # Specify the subnet where the instance will be launched

  # Root volume configuration
  root_block_device {
    volume_size = var.root_volume
    volume_type = "gp3"
  }

  key_name = var.key_name  # Name of the SSH key pair used to access the instance

  # Instance tags
 tags = merge(var.tags, {
  Name = format("db-bastion-host-%s-%s-%s", var.tags["environment"], var.tags["project"], var.tags["owner"])
})
  user_data = file("${path.module}/scripts/pgadmin_setup.sh")



}
