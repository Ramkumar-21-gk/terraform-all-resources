terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_security_group" "my_sg" {
  tags = {
    Name = "nginx_sg"
  }
}

data "aws_vpc" "my_vpc" {
  tags = {
    Name = "my_vpc"
  }
}
data "aws_availability_zones" "zones" {
  state = "available"
}
data "aws_subnet" "private_subnet" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.my_vpc.id]
  }
  tags={
    Name = "private_subnet"
  }
}
output "vpc" {
  value = data.aws_vpc.my_vpc.id
}
output "sg" {
  value = data.aws_security_group.my_sg.id
}
output "zones" {
  value = data.aws_availability_zones.zones
}

resource "aws_instance" "newServer" {
  ami           = "ami-07a00cf47dbbc844c"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ data.aws_security_group.my_sg.id ]
  subnet_id = data.aws_subnet.private_subnet.id

  tags = {
    Name = "newServer"
  }
}