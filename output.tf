output "virtual_network_id" {
  value = module.vnet.resource_id
}
output "resource_group_name" {
  value = module.avm-res-resources-resourcegroup.name
}
output "virtual_network_name" {
  value = module.vnet.name
}
