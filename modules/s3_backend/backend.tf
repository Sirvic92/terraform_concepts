terraform {
  backend "s3" {
    bucket         = "victor-terraform-state-bucket"  # Replace with the bucket name you created
    key            = "terraform.tfstate"   # Path to your state file
    region         =  "us-east-1"           # Replace with the region
    encrypt        = true
    dynamodb_table = "TerraformStateFile"  # Replace with the table name you created
  }
}
