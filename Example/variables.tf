variable "create_resource_group" {
  type    = bool
  default = false
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "vnets" {
  type = map(object({
    name          = string
    address_space = list(string)
  }))
}

variable "subnets" {
  type = map(object({
    name            = string
    vnet_name       = string
    address_prefixes = list(string)
  }))
}
#
#variable "nsgs" {
#  type = map(object({
#    name = string
#  }))
#}
