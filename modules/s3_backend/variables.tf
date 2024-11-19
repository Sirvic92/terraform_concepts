variable "bucket_name" {
  description = "Name of the S3 bucket to store Terraform state"
  type        = string
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-state-locks"
}

variable "enable_locking" {
  description = "Enable DynamoDB for state locking"
  type        = bool
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)

}

variable "aws_region" {
    type = string
}