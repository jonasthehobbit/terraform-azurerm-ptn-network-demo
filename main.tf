# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  suffix  = ["mmu-demo"]
}

# Create resource group using AVM module
module "resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.1.0"
  # insert the 2 required variables here
  location = var.location
  name     = module.naming.resource_group.name_unique
  tags     = var.tags
}
# Creating a virtual network with a unique name, telemetry settings, and in the specified resource group and location.
module "vnet" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.4.0"
  name                = module.naming.virtual_network.name_unique
  resource_group_name = module.avm-res-resources-resourcegroup.name
  location            = var.location
  address_space       = var.vnet_address_spaces
  tags                = var.tags
}
# Create default subnets in the virtual network - other subnets are created elsewhere...
resource "azurerm_subnet" "defaults" {
  for_each             = var.subnet_address_spaces
  name                 = each.value.name
  resource_group_name  = module.avm-res-resources-resourcegroup.name
  virtual_network_name = module.vnet.name
  address_prefixes     = each.value.address_prefixes
}
# Create a default NSG using AVM module
module "networksecuritygroup" {
  source  = "Azure/avm-res-network-networksecuritygroup/azurerm"
  version = "0.2.0"
  # insert the 3 required variables here
  resource_group_name = module.avm-res-resources-resourcegroup.name
  location            = var.location
  name                = module.naming.network_security_group.name_unique
  tags                = var.tags
  security_rules      = var.network_security_group_rules
}
# Attach the default NSG to the default subnets
resource "azurerm_subnet_network_security_group_association" "defaults" {
  for_each                  = var.subnet_address_spaces
  subnet_id                 = azurerm_subnet.defaults[each.key].id
  network_security_group_id = module.networksecuritygroup.resource_id
}
