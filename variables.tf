
variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "uksouth"
}
variable "subnets" {
  description = "A map of subnets to create in the virtual network."
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}
