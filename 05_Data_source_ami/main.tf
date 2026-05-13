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

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}

output "ec2_ami" {
  value = data.aws_ami.name.id
}

data "aws_security_group" "my_sg" {
  tags = {
    Name = "nginx_sg"
  }
}
output "sg" {
  value = data.aws_security_group.my_sg.id
}

data "aws_vpc" "my_vpc" {
  tags = {
    Name = "my_vpc"
  }
}

output "vpc" {
  value = data.aws_vpc.my_vpc.id
}

data "aws_caller_identity" "name" {
  
}
output "name" {
  value = data.aws_caller_identity.name
}
resource "aws_instance" "myserver" {
  ami           = "ami-07a00cf47dbbc844c"
  instance_type = "t2.micro"

  tags = {
    Name = "myserver"
  }
}