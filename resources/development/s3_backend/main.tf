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


  aws_region     = "us-east-1"
  enable_locking = true
  force_destroy  = true
  tags = {
    "id"             = "2024"
    "owner"          = "victor"
    "environment"    = "dev"
    "project"        = "learning"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"
  }

}
module "s3_backend" {
  source         = "../../../modules/s3_backend"
  aws_region     = local.aws_region
  tags           = local.tags
  force_destroy  = local.force_destroy
  enable_locking = local.enable_locking


}
