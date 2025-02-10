
variable "vpc_cidr" {
    type = string
  
}

variable "subnet_cidr" {
    type = string
  
}

resource "aws_vpc" "hirose_vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags = {
        Name = "aws_vpc_hirose"
    }
  
}

resource "aws_subnet" "hirose_subnet" {
    vpc_id = aws_vpc.hirose_vpc.id

    cidr_block = "${var.subnet_cidr}"
    tags = {
         Name = "aws_subnet_hirose"
    }
  
}