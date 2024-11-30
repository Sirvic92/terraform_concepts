resource "aws_dynamodb_table" "terraform_locks" {
  count    = var.enable_locking ? 1 : 0
  name     = format("%s-%s-%s-dynamodb-backend-%s", var.tags["environment"], var.tags["project"], var.tags["owner"], var.aws_region)
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

    tags = var.tags
}