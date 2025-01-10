variable "aws_region" {
    type = string
}
variable "allocated_storage" {
  description = "The allocated storage for the database in gigabytes (GB)"
  type        = number
}

variable "engine" {
  description = "The database engine type (e.g., postgres, mysql)"
  type        = string
}

variable "engine_version" {
  description = "The version of the database engine"
  type        = string

}

variable "instance_class" {
  description = "The instance class of the database (e.g., db.t2.micro)"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "subnet_ids" {
  description = "A list of private subnet IDs for the database subnet group"
  type        = list(string)
}

variable "identifier" {
  description = "A list of private subnet IDs for the database subnet group"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "The security group ID"
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Whether to skip the final snapshot"
  type        = bool
}

variable "publicly_accessible" {
  description = "Whether the DB instance is publicly accessible"
  type        = bool
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)

}

# variable "username" {
# type        = string

# }

# variable "password" {
# type        = string

# }