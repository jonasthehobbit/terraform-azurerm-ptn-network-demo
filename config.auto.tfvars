location = "uksouth"
subnets = {
  "shared_data" = {
    name             = "shared_data"
    address_prefixes = ["10.0.0.0/24"]
  }
  "shared_compute" = {
    name             = "shared_compute"
    address_prefixes = ["10.0.1.0/24"]
  }
}