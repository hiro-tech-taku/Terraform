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

module "vpc" {
  source = "../../S3"

  vpc_cidr = "10.0.0.0/16"
  subnet_cidr = "10.0.0.0/20"

}