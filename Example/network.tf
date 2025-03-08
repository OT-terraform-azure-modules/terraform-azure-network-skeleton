module "network" {
  source                 = "../Network-skeleton"
  create_resource_group  = var.create_resource_group
  resource_group_name    = var.resource_group_name
  location               = var.location
  vnets                  = var.vnets
  subnets                = var.subnets
#  nsgs                   = var.nsgs
}
