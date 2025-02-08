# provider "aws" {
#     region = "ap-northeast-1"  
# }

# resource "aws_vpc" "hirose_vpc" {
#     cidr_block = "10.0.0.0/16"
#     tags = {
#         Name = "aws_vpc_hirose"
#     }
  
# }

# resource "aws_subnet" "hirose_subnet" {
#     vpc_id = aws_vpc.hirose_vpc.id

#     cidr_block = "10.0.0.0/24"
#     tags = {
#          Name = "aws_subnet_hirose"
#     }
  
# }