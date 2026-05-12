
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.44.0"
    }
  }
  backend "s3" {
    bucket = "demo-bucket-797a28736fc484ae"
    key = "terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "myserver" {
  ami           = "ami-07a00cf47dbbc844c"
  instance_type = "t2.micro"

  tags = {
    Name = "myserver"
  }
}