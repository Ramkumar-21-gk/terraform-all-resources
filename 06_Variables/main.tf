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
  name="ship"
}

resource "aws_instance" "myserver" {
  ami           = "ami-07a00cf47dbbc844c"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size = var.ec2_objects.v_size
    volume_type = var.ec2_objects.v_type
  }

  tags = merge(var.additional_tag,{
    Name = "myserver"
    transport= local.name
  })
}