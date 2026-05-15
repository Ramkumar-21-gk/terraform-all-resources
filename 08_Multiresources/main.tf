
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

locals {
  project="project-01"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    project ="${local.project}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block =  "10.0.${count.index}.0/24"
  count = 2
  tags = {
    project = "${local.project}-subnet-${count.index}"   
  }
}

# creating 2 ec2 with diffrent emi
resource "aws_instance" "server" {
  for_each = var.ec2_map
  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id = element(aws_subnet.main[*].id,index(keys(var.ec2_map),each.key) %length(aws_subnet.main))

  tags = {
    Name = "${local.project}-server-${each.key}"
  }
}

# creating 4 ec2 instance
# resource "aws_instance" "server" {
#   ami           = "ami-07a00cf47dbbc844c"
#   instance_type = "t3.micro"
#   count = 4
#   subnet_id = element(aws_subnet.main[*].id,count.index%length(aws_subnet.main))

#   tags = {
#     Name = "${local.project}-server-${count.index}"
#   }
# }

