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
  aws_region         = "us-east-1"
  cidr_block         = "10.10.0.0/16"
  no_public_subnets  = 3
  no_private_subnets = 3
  subnet_bits        = 4
  number_of_nat      = 3

  tags = {
    "id"             = "2024"
    "owner"          = "Victor"
    "environment"    = "dev"
    "project"        = "learning"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"
  }
}


terraform {
  backend "s3" {
    bucket         = "dev-learning-victor-s3-backend-us-east-1" # Replace with the bucket name you created
    key            = "vpc/terraform.tfstate"                    # Path to your state file
    region         = "us-east-1"                                # Replace with the region
    encrypt        = true
    dynamodb_table = "dev-learning-victor-dynamodb-backend-us-east-1" # Replace with the table name you created
  }
}


module "vpc" {
  source             = "../../../modules/vpc"
  aws_region         = local.aws_region
  cidr_block         = local.cidr_block
  no_public_subnets  = local.no_public_subnets
  no_private_subnets = local.no_private_subnets # Corrected the variable name here
  subnet_bits        = local.subnet_bits
  number_of_nat      = local.number_of_nat
  tags               = local.tags
}

