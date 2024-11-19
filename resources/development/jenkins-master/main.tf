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
  aws_region    = "us-east-1"
  root_volume   = 10
  instance_type = "t2.micro"
  key_name      = "window-pair"
  resource_type = "apache-1-4"
  tags = {
    "Name"           = "elastic_ip"
    "owner"          = "Victor Orji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"
  }


}
module "jenkins-master" {
  source        = "../../../modules/ec2"
  aws_region    = local.aws_region
  root_volume   = local.root_volume
  instance_type = local.instance_type
  key_name      = local.key_name
  resource_type = local.resource_type
  tags          = local.tags

}