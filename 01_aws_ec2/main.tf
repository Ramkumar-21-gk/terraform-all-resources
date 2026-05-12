# variable "region" {
#   description = "value of region"
#   type = string
#   default = "ap-south-1"
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "myserver" {
  ami           = "ami-07a00cf47dbbc844c"
  instance_type = "t2.micro"

  tags = {
    Name = "myserver"
  }
}