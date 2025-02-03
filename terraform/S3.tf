terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

# provider "aws" {
#   # Configuration options
# }

# resource "aws_s3_bucket" "hirose_s3" {
#   bucket = "hirose-s3bucket"

#   tags = {
#     Name        = "hirose s3bucket"
#     Environment = "Dev"
#   }
# }
