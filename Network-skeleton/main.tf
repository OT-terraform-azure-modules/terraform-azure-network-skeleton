#locals {
#  nsg_associations = var.nsg_associations
#}

resource "azurerm_resource_group" "modular_rg" {
  count    = var.create_resource_group ? 1 : 0
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "modular_vnet" {
  for_each = { for idx, vnet in var.vnets : idx => vnet }

  name                = each.value.name
  location            = var.location
  resource_group_name = var.create_resource_group ? azurerm_resource_group.modular_rg[0].name : var.resource_group_name
  address_space       = each.value.address_space
}

resource "azurerm_subnet" "modular_subnet" {
  for_each = { for key, subnet in var.subnets : key => subnet }

  name                 = each.value.name
  resource_group_name  = var.create_resource_group ? azurerm_resource_group.modular_rg[0].name : var.resource_group_name
  # virtual_network_name = each.value.vnet_name
  virtual_network_name = azurerm_virtual_network.modular_vnet[each.value.vnet_name].name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_security_group" "modular_nsg" {
  for_each = { for key, nsg in var.nsgs : key => nsg }

  name                = each.value.name
  location            = var.location
  resource_group_name = var.create_resource_group ? azurerm_resource_group.modular_rg[0].name : var.resource_group_name
}

resource "azurerm_network_security_rule" "modular_nsg_rule" {
  for_each = { for key, rule in var.nsg_rules : key => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  network_security_group_name = azurerm_network_security_group.modular_nsg[each.value.nsg_key].name
  resource_group_name         = var.create_resource_group ? azurerm_resource_group.modular_rg[0].name : var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "modular_nsg_assoc" {
  for_each = var.nsg_associations

  subnet_id                 = azurerm_subnet.modular_subnet[each.value.subnet_key].id
  network_security_group_id = azurerm_network_security_group.modular_nsg[each.value.nsg_key].id
}