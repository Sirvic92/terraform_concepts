variable "aws_region" {
  type = string
}


variable "inbound_ports" {
  description = "List of inbound ports to allow in the security group"
  type        = list(number)
}


variable "tags" {
  type = map(string)

}

variable "sg_resource_name" {
  type    = string


}
