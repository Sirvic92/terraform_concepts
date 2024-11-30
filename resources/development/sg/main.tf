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
  aws_region    = "us-west-1"
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

terraform {
  backend "s3" {
    bucket         = "victor-terraform-state-bucket"  # Replace with the bucket name you created
    key            = "north-virginia-sg/terraform.tfstate"   # Path to your state file
    region         =  "us-east-1"           # Replace with the region
    encrypt        = true
    dynamodb_table = "TerraformStateFile"  # Replace with the table name you created
  }
}



module "north-virginia-sg" {
  source        = "../../../modules/sg"
  aws_region    = local.aws_region
  tags          = local.tags
  inbound_ports = local.inbound_ports
  sg_resource_name = local.sg_resource_name

}

