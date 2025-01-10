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
  secret = ["db_secret", "api_secret"]

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
    bucket         = "dev-learning-victor-s3-backend-us-east-1" 
    key            = "secret_manager/terraform.tfstate"                    
    region         = "us-east-1"                                
    encrypt        = true
    dynamodb_table = "dev-learning-victor-dynamodb-backend-us-east-1" 
  }
}

module "secret_manager" {
  source             = "../../../modules/secret_manager"
  secrets = local.secret
  aws_region = local.aws_region
  tags               = local.tags
}


