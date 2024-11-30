variable "enable_locking" {
  description = "Enable DynamoDB for state locking"
  type        = bool
}

variable "force_destroy" {
  description = "decides if the resource should be deleted or not"
  type        = bool
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)

}

variable "aws_region" {
    type = string
}