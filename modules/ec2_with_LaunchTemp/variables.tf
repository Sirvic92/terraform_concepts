variable "aws_region" {
  type = string
}

variable "root_volume" {
  type = number

}

variable "instance_type" {
  type = string

}

variable "key_name" {
  type = string

}

variable "resource_type" {
  type = string

}


variable "tags" {
  type = map(string)

}



