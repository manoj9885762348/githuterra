provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform_files"
  acl    = "private"

  versioning {
    enabled = true
  }
}

terraform {
  backend "s3" {
    bucket         = aws_s3_bucket.terraform_state.id
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "terraform_locks"
    encrypt        = true
  }
}

resource "aws_instance" "example" {
  ami           = "your_ami_id"
  instance_type = "t2.micro"
  tags = {
    Name = "first github action"
  }
}
