variable "aws_region" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "cidr_block" {
  type = string
}

variable "no_public_subnets" {
  type = number
}

variable "no_private_subnets" { # Corrected the name here
  type = number
}

variable "subnet_bits" {
  type = number
}

variable "number_of_nat" {
  type = number
}
