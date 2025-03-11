output "resource_group_name" {
  value = var.create_resource_group ? azurerm_resource_group.modular_rg[0].name : var.resource_group_name
}

output "vnets" {
  value = { for key, vnet in azurerm_virtual_network.modular_vnet : key => vnet.name }
}

output "vnet_ids" {
  value = { for key, vnet in azurerm_virtual_network.modular_vnet : key => vnet.id }
}


output "subnets" {
  value = { for key, subnet in azurerm_subnet.modular_subnet : key => subnet.name }
}

output "subnet_ids" {
  value = { for key, subnet in azurerm_subnet.modular_subnet : key => subnet.id }
}

output "nsgs" {
  value = { for key, nsg in azurerm_network_security_group.modular_nsg : key => nsg.name }
}
