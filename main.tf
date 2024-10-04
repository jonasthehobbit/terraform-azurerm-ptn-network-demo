# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  suffix  = ["mmu-demo"]
}

# This is required for resource modules

module "avm-res-resources-resourcegroup" {
  source  = "Azure/avm-res-resources-resourcegroup/azurerm"
  version = "0.1.0"
  # insert the 2 required variables here
  location = var.location
  name     = module.naming.resource_group.name_unique
  tags = {
    environment = "dev"
    owner       = "terraform"
  }
}

# Creating a virtual network with a unique name, telemetry settings, and in the specified resource group and location.
module "vnet" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.4.0"
  name                = module.naming.virtual_network.name_unique
  resource_group_name = module.avm-res-resources-resourcegroup.name
  location            = var.location

  address_space = var.vnet_address_spaces
}
resource "azurerm_subnet" "default" {
  for_each             = var.subnet_address_spaces
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = module.vnet.name
  address_prefixes     = each.value.address_prefixes
}
