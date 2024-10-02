
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
