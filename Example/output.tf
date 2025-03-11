output "resource_group_name" {
  value = module.network.resource_group_name
}

output "vnets" {
  value = [for vnet in module.network.vnets : vnet]
}

output "vnet_ids" {
  value = [for vnet in module.network.vnet_ids : vnet]
}

output "subnets" {
  value = [for subnet in module.network.subnets : subnet]
}

output "subnet_ids" {
  value = [for subnet in module.network.subnet_ids : subnet]
}