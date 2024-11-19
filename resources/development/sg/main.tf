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
  inbound_ports = [22, 80, 2000, 2001]  
  aws_region    = "us-east-2"
  sg_resource_name ="terraform_sg"
  tags = {
    "Name"           = "elastic_ip"
    "owner"          = "Victor Orji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"
  }


}
module "ohio-security-group" {
  source        = "../../../modules/sg"
  aws_region    = local.aws_region
  tags          = local.tags
  inbound_ports = local.inbound_ports
  sg_resource_name = local.sg_resource_name

}

