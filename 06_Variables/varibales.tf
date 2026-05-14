variable "aws_instance_type" {
  description = "Enter the ec2 instance type: "
  type = string
  validation {
    condition = var.aws_instance_type=="t2.micro" || var.aws_instance_type=="t3.micro"
    error_message = "only accept t2 and t3 micro"
  }
}

variable "root_volume_size" {
  type = number
  default = 10
}

variable "root_volume_type" {
  type = string
  default = "gp2"
}

variable "ec2_objects" {
  type=object({
    v_size = number,
    v_type = string 
  })
  default = {
    v_size = 12
    v_type = "gp2"
  }
}

variable "additional_tag" {
  type=map(string)
  default = {
    "country" = "Ind"
  }
}