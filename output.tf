output "virtual_network_id" {
  value = module.vnet.virtual_network_id
}
output "resource_group_name" {
  value = azurerm_resource_group.main.name
}
