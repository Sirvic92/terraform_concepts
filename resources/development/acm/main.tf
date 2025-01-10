terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}



locals {
  aws_region               = "us-east-1"
  domain_name              = "sirvictech.com"
  subject_alternative_names = "*.sirvictech.com"
  tags = {
    "id"             = "2024"
    "owner"          = "victororji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"

  }

}

module "acm" {
  source                   = "../../../modules/acm" 
  aws_region               = local.aws_region
  domain_name              = local.domain_name
  subject_alternative_names = local.subject_alternative_names
  tags                     = local.tags
}