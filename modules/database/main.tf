resource "aws_db_subnet_group" "db_subnets" {
name = format("%s-%s-%s-db_subnets", var.tags["environment"], var.tags["project"], var.tags["owner"])

  subnet_ids  = var.subnet_ids  # Subnet IDs for private subnets
  description = "Database subnet group"
}




resource "aws_db_instance" "HR" {
  allocated_storage      = var.allocated_storage
  identifier             = var.identifier
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  db_name                = var.db_name
  username = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["database_username"]
  password = jsondecode(data.aws_secretsmanager_secret_version.db_secret_version.secret_string)["database_password"]
  parameter_group_name   = "default.postgres16"
  vpc_security_group_ids = var.vpc_security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  skip_final_snapshot    = var.skip_final_snapshot
  publicly_accessible    = var.publicly_accessible

  tags = var.tags
}
