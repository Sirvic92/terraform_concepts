provider "aws" {
  region = var.aws_region
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


locals {
  ## Variables for Data Base
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "16.3"
  instance_class         = "db.t3.micro"
  db_name                = "HR_DATABASE"
  identifier             = "education"
  skip_final_snapshot    = true
  publicly_accessible    = true
  subnet_ids             = module.vpc.private_subnet_ids
  vpc_security_group_ids = module.security_group.security_group_id


  ### VPC ####
  aws_region         = "us-east-1"
  cidr_block         = "10.10.0.0/16"
  no_public_subnets  = 3
  no_private_subnets = 3
  subnet_bits        = 4
  number_of_nat      = 1

  ### DB security_group
  vpc_id           = module.vpc.vpc_id
  inbound_ports    = [5432]
  sg_resource_name = "db_sg"
  tags = {
    "id"             = "2024"
    "owner"          = "victororji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"

  }

  # varibale for bastion host
  #aws_region    = "us-east-1"
  root_volume   = 10
  instance_type = "t2.micro"
  key_name      = "window-pair"
  subnet_id     = module.vpc.public_subnet_ids[0]
  
}

terraform {
  backend "s3" {
    bucket         = "dev-learning-victor-s3-backend-us-east-1" 
    key            = "database/terraform.tfstate"                    
    region         = "us-east-1"                                
    encrypt        = true
    dynamodb_table = "dev-learning-victor-dynamodb-backend-us-east-1" 
  }
}



# Call the VPC module to create VPC and subnets
module "vpc" {
  source             = "../../../modules/vpc"
  aws_region         = local.aws_region
  cidr_block         = local.cidr_block
  subnet_bits        = local.subnet_bits
  number_of_nat      = local.number_of_nat
  no_private_subnets = local.no_private_subnets
  no_public_subnets  = local.no_public_subnets
  tags               = local.tags
}


# Call the Security Group module
module "security_group" {
  source           = "../../../modules/sg" # Path to the Security Group module
  vpc_id           = local.vpc_id          # Pass VPC ID from VPC module
  inbound_ports    = local.inbound_ports   # Inbound ports (e.g., 5432)
  sg_resource_name = local.sg_resource_name
  aws_region       = local.aws_region
  tags             = local.tags
}

# Call the Database (RDS) module
module "dbs" {
  source            = "../../../modules/database"
  allocated_storage = local.allocated_storage
  identifier        = local.identifier
  aws_region        = local.aws_region
  engine            = local.engine
  engine_version    = local.engine_version
  instance_class    = local.instance_class
  db_name           = local.db_name
  subnet_ids        = local.subnet_ids
  #   username               = local.username
  #   password               = local.password
  #db_subnet_group_name   = local.db_subnet_group_name
  vpc_security_group_ids = [module.security_group.security_group_id]
  skip_final_snapshot    = local.skip_final_snapshot
  publicly_accessible    = local.publicly_accessible

  tags = local.tags
}
# Call the Security Group module
module "bastion-host" {
  source        = "../../../modules/DB-bastion-host" # Path to the Security Group module
  aws_region = local.aws_region
  vpc_id          = module.vpc.vpc_id
  root_volume   = local.root_volume
  instance_type = local.instance_type
  key_name      = local.key_name
  subnet_id     = local.subnet_id
  tags          = local.tags
}