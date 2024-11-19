resource "aws_dynamodb_table" "terraform_locks" {
  count    = var.enable_locking ? 1 : 0
  name     = var.dynamodb_table_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    var.tags,
    {
      Name = format("%s-%s-%s", var.tags["environment"], var.tags["project"], var.dynamodb_table_name)
    }
  )
}