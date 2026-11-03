terraform {
  backend "s3" {
    bucket         = "redis-assignment-tfstate-574246332259-us-east-1"
    key            = "redis-assignment/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-locks"
  }
}
