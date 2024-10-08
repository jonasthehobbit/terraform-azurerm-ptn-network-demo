
variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "uksouth"
}
variable "vnet_address_spaces" {
  description = "The address spaces to use for the virtual network."
  type        = list(string)
}
variable "subnet_address_spaces" {
  description = "A map of subnets to create in the virtual network."
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}
variable "required_tags" {
  type = object({
    environment = optional(string, "dev")
    costcenter  = optional(string, "702200")
    owner       = optional(string, "IT Team")
  })
}
variable "tags" {
  type = map(string)
  default = {}  
}
variable "network_security_group_rules" {
  description = "A map of network security group rules to create."
  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = {}
}
