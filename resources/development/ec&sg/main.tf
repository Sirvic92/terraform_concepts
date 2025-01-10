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
  root_volume   = 10
  instance_type = "t2.micro"
  key_name      = "window-pair"
  resource_type = "apache-14"
  inbound_ports = [22, 80, 2000, 2001]  
  aws_region    = "us-east-1"
  sg_resource_name ="terraform_sg-apache"
  tags = {
   
    "owner"          = "Victor Orji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"
  }
   
}
terraform {
  backend "s3" {
    bucket         = "dev-learning-victor-s3-backend-us-east-1"  # Replace with the bucket name you created
    key            = "jenkins-master/terraform.tfstate"   # Path to your state file
    region         =  "us-east-1"           # Replace with the region
    encrypt        = true
    dynamodb_table = "dev-learning-victor-dynamodb-backend-us-east-1"  # Replace with the table name you created
  }
}

module "security_group" {
  source        = "../../../modules/sg"
  aws_region    = local.aws_region
  tags          = local.tags
  inbound_ports = local.inbound_ports
  sg_resource_name = local.sg_resource_name

}






module "jenkins-master" {
  source        = "../../../modules/ec2"
  aws_region    = local.aws_region
  security_group_id = module.security_group.security_group_id
  root_volume   = local.root_volume
  instance_type = local.instance_type
  key_name      = local.key_name
  resource_type = local.resource_type
  tags          = local.tags

}