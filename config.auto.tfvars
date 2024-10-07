location            = "uksouth"
vnet_address_spaces = ["10.0.0.0/16"]
subnet_address_spaces = {
  "shared_data" = {
    name             = "shared_data"
    address_prefixes = ["10.0.0.0/24"]
  }
  "shared_compute" = {
    name             = "shared_compute"
    address_prefixes = ["10.0.1.0/24"]
  }
}
tags = {
  costcode    = "123456"
  owner       = "terraform"
  environment = "dev"
}
