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
  
 instance_type = "t2.micro"  # Use "=" to define key-value pairs
  no_instances  = 3
  vpc_id       = module.vpc.vpc_id
  aws_region         = "us-east-1"
  cidr_block         = "10.10.0.0/16"
  no_public_subnets  = 3
  no_private_subnets = 3
  subnet_bits        = 4
  number_of_nat      = 3
  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_ids = module.vpc.public_subnet_ids


  tags = {
    "id"             = "2024"
    "owner"          = "victororji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"

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
module "load_balancer" {
  source           = "../../../modules/host_routing_1" # Path to the Security Group module
  vpc_id           = local.vpc_id          # Pass VPC ID from VPC module
  aws_region       = local.aws_region
  public_subnet_ids = local.public_subnet_ids
  private_subnet_ids = local.private_subnet_ids
  no_instances = local.no_instances
  instance_type = local.instance_type
  tags             = local.tags
}

