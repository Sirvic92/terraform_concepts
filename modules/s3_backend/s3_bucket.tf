resource "aws_s3_bucket" "terraform_state" {
  bucket = format("%s-%s-%s-s3-backend-%s", var.tags["environment"], var.tags["project"], var.tags["owner"], var.aws_region)
  force_destroy = var.force_destroy 


  lifecycle {
    prevent_destroy = false
  }

  tags = var.tags
}

# resource "aws_s3_bucket_acl" "terraform_state" {
#   bucket = aws_s3_bucket.terraform_state.id
#   acl    = "private"
# }

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
