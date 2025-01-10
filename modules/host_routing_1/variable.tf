variable "aws_region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vpc_id" {
  type = string
}

variable "no_instances" {
  type = number
}


variable "instance_type" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
  
}

variable "public_subnet_ids" {
  type = list(string)
  
}