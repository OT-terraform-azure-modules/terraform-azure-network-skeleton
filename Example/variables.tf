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

variable "nsgs" {
  type = map(object({
    name = string
  }))
}

variable "nsg_rules" {
  description = "Map of NSG rules."
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
    nsg_key                    = string
  }))
  default = {}
}

variable "nsg_associations" {
  description = "Map of NSG associations to subnets."
  type = map(object({
    subnet_key = string
    nsg_key    = string
  }))
  default = {}
}