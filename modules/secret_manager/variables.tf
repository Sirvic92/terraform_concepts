variable "aws_region" {
  type = string
}


variable "tags" {
  type = map(string)

}

variable "secrets" {
  type = list(string)
  
}


