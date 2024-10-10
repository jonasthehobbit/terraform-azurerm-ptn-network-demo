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
  test        = "some_tag"
}
network_security_group_rules = {
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
  allow_risk1 = {
    name                       = "allow_risk1"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  allow_risk2 = {
    name                         = "allow_risk2"
    priority                     = 200
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "*"
    source_port_range            = "*"
    destination_port_range       = "*"
    source_address_prefixes      = ["*"]
    destination_address_prefixes = ["*"]
  }
  allow_risk3 = {
    name                         = "allow_risk3"
    priority                     = 300
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "*"
    source_port_ranges           = "*"
    destination_port_ranges      = ["22", "3389"]
    source_address_prefixes      = ["*"]
    destination_address_prefixes = ["*"]
  }
}
