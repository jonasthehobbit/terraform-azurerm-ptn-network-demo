output "virtual_network_id" {
  value = module.vnet.resource_id
}
output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
