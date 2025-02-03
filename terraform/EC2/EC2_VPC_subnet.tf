provider "aws" {
  region = "ap-northeast-1"
}

locals {
  app_name = "hirose"
  name_prefix = "${var.env}-${local.app_name}"
}

variable "env" {
  type = string
  default = "handson"
}

variable "myip" {
  type = string
  description = "Check-> https://www.whatismyip.com/"
}

resource "aws_vpc" "hirose_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${local.name_prefix}-vpc"
  }
}

resource "aws_subnet" "hirose_subnet" {
  vpc_id = aws_vpc.hirose_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    "Name" = "${local.name_prefix}-subnet"
  }

}

resource "aws_route_table" "hirose_public_rtb" {
  vpc_id = aws_vpc.hirose_vpc.id
  
  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_internet_gateway.hirose_igw.id
  } 

  tags = {
    "Name" = "${local.name_prefix}-public-rtb" 
  }
}

resource "aws_route_table_association" "hirose_public_rtb_assoc" {
  subnet_id = aws_subnet.hirose_subnet.id
  route_table_id = aws_route_table.hirose_public_rtb.id
}

resource "aws_internet_gateway" "hirose_igw" {
  vpc_id = aws_vpc.hirose_vpc.id

  tags = {
    "Name" = "${local.name_prefix}-igw"
  }
}

resource "aws_security_group" "hirose_sg" {
  vpc_id = aws_vpc.hirose_vpc.id

  name = "${local.name_prefix}-sg"
  description = "Allow HTTP access from my IP"

  ingress {
    description = "Allow HTTP traffic from my IP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.myip}/32"] # var.myipからのHTTPアクセスを許可
  }
  egress {
     from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${local.name_prefix}-sg"
  }
}

resource "aws_instance" "hirose_ec2" {
  ami = "ami-094dc5cf74289dfbc"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.hirose_sg.id ]
  subnet_id = aws_subnet.hirose_subnet.id

  user_data = <<-EOF
  #!/bin/bash
  dnf update -y
  dnf install -y nginx
  systemctl enable --now nginx
  cat <<HTML > /usr/share/nginx/html/index.html
    <div style="text-align:center; font-size:1.5em; color:#333; margin:20px; line-height:1.8;">
    <b>env: ${var.env}</b><br>
        <b>app_name: ${local.app_name}</b><br>
        <b>name_prefix: ${local.name_prefix}</b><br>
        <b>myip: ${var.myip}</b>
    </div>
HTML
  EOF

  tags = {
    "Name" = "${local.name_prefix}-ec2"
  }
}