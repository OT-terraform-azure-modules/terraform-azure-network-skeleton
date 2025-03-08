# terraform-azure-network-skeleton

This module is designed to provision the complete network skeleton comprising of the below components

```
- Resource Group
- Multiple Vnets based on the user inputs
- Multiple Subnets based on the user inputs
- Multiple NSGs based on the user inputs
- Multiple NSG rules based on the user inputs
- NSG and Subnet association
```

## Usage

- To use the module refer the `Example` directory which highlights the complete usage of the module.
- Refer to the branch `v1.0.0` in your environment to use the stable version of the module `git::https://github.com/OT-terraform-azure-modules/terraform-azure-network-skeleton.git?ref=v1.0.0`
- The below inputs are required for the module to run:
    - create_resource_group: Boolean value either `true` or `false`
    - resource_group_name: String value for the resource group name
    - location: String value for the location of the resources
    - vnets: Map of objects comprising of the Vnet details to be created
        - Example:
            vnets = {
              qa-service-vnet = {
                name          = "qa-service-vnet"
                address_space = ["10.10.0.0/16"]
              }
              qa-sharedservice-vnet = {
                name          = "qa-sharedservice-vnet"
                address_space = ["10.20.0.0/16"]
              }
            }
    - subnets: Map of objects comprising of the Subnets details to be created
        - Example:
            subnets = {
              qa-service-subnet = {
                name            = "qa-service-subnet"
                vnet_name       = "qa-service-vnet"
                address_prefixes = ["10.10.1.0/24"]
              }
              qa-sharedservice-subnet = {
                name            = "qa-sharedservice-subnet"
                vnet_name       = "qa-sharedservice-vnet"
                address_prefixes = ["10.20.1.0/24"]
              }
            }
    - nsgs: Map of objects comprising of the NSGs details to be created
        - Example:
            ```
            nsgs = {
              qa-service-nsg = {
                name = "qa-service-nsg"
              }
              qa-sharedservice-nsg = {
                name = "qa-sharedservice-nsg"
              }
            }
            ```
    - nsg_rules: Map of objects comprising of the NSG rules details to be created
        - Example:
            ```
            nsg_rules = {
              qa-service-allow-http = {
                name                       = "Allow_HTTP"
                priority                   = 100
                direction                  = "Inbound"
                access                     = "Allow"
                protocol                   = "Tcp"
                source_port_range          = "*"
                destination_port_range     = "80"
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                nsg_key                    = "qa-service-nsg"
              }
              qa-sharedservice-allow-rdp = {
                name                       = "Allow_RDP"
                priority                   = 110
                direction                  = "Inbound"
                access                     = "Allow"
                protocol                   = "Tcp"
                source_port_range          = "*"
                destination_port_range     = "3389"
                source_address_prefix      = "*"
                destination_address_prefix = "*"
                nsg_key                    = "qa-sharedservice-nsg"
              }
            }
            ```
    - nsg_associations: Map of objects comprising of the NSG associations details to be created
        - Examples:
            ```
              nsg_associations = {
                qa-service-nsg-assoc = {
                  subnet_key = "qa-service-subnet"
                  nsg_key    = "qa-service-nsg"
                }
                qa-sharedservice-nsg-assoc = {
                  subnet_key = "qa-sharedservice-subnet"
                  nsg_key    = "qa-sharedservice-nsg"
                }
              }
            ```
- The backend will be stored in the stroage account in Azure, the backend details are mentioned in the `backend.tf`
- Execute `terraform init` to initialize the module and the remote backend.
- Then execute `terraform plan` to list the implementation dry run.
- Then execute `terraform apply` to deploy the network skeleton.
- Once the execution is successful on the ternal output the `subnet_ids` would be displayed that would be used for the compute module execution.