terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.85.0"
    }
  }
}

provider "aws" {
    region = "ap-northeast-1"
  
}

resource "aws_s3_object" "object" {
  bucket = "awsc-hirose-285-test"
  key    = "terraform.tfstate"
}