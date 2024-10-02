# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.1"
  suffix  = ["mmu-demo"]
}

# This is required for resource modules
resource "azurerm_resource_group" "main" {
  location = var.location
  name     = module.naming.resource_group.name_unique
}

# Creating a virtual network with a unique name, telemetry settings, and in the specified resource group and location.
module "vnet" {
  source              = "Azure/avm-res-network-virtualnetwork/azurerm"
  version             = "0.4.0"
  name                = module.naming.virtual_network.name_unique
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  address_space = ["10.0.0.0/16"]
}
