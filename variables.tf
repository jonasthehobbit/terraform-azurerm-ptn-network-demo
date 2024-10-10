
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
variable "tags" {
  description = "A map of tags to add to all resources in this example."
  type        = map(string)
  default = {
    costcode    = "123456"
    owner       = "terraform"
    environment = "dev"
  }
}
variable "network_security_group_rules" {
  description = "A map of network security group rules to create."
  type = map(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_range            = string
    destination_port_range       = optional(string)
    destination_port_ranges      = optional(list(string))
    source_address_prefix        = optional(string)
    destination_address_prefix   = optional(string)
    source_address_prefixes      = optional(list(string))
    destination_address_prefixes = optional(list(string))
  }))
  default = {
    default_deny = {
      name                       = "default_deny"
      priority                   = 4000
      direction                  = "Inbound"
      access                     = "Deny"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_range     = "*"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }
}
