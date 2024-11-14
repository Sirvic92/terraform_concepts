variable "aws_region" {
  type    = string
  default = "us-east-1"

}

variable "tags" {
  type = map(string)
  default = {
    "Name"           = "elastic_ip"
    "owner"          = "Victor Orji"
    "environment"    = "dev"
    "project"        = "del"
    "created_by"     = "Terraform"
    "Cloud_provider" = "aws"
  }




}


