provider "aws" {
    region = "us-east-1"
  
}

## Terraform block

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}

terraform {
  
}
