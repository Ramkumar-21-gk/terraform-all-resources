terraform {}

variable "list_value" {
  type = list(number)
  default = [ 0,1,2,3 ]
}

variable "object_in_list" {
  type = list(object({
    name = string,
    age = number
  }))
  default = [ {
    name = "ram",
    age = 23
  } ]
}

variable "map_values" {
  type = map(number)
  default = {
    "one" = 1
    "two" = 2
    "three" =3
  }
}

output "output" {
  value = var.object_in_list
}

locals {
  num=5*5
  double=[for num in var.list_value: num]
  new=[for key in var.object_in_list: key.name]
  map=[for k,v in var.map_values: v]
  double_map={for k,v in var.map_values: k=>v*5}
}
output "cal" {
  value = local.double_map
}