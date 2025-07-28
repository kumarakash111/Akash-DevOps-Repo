module "resource_group" {
  source                  = "../Child_modules/azurerm_resource_group"
  resource_group_name     = "aktestrg"
  resource_group_location = "West us"
}

module "virtual_network" {
  depends_on              = [module.resource_group]
  source                  = "../child_modules/azurerm_virtual_network"
  virtual_network_name    = "aktestvnet"
  resource_group_name     = "aktestrg"
  resource_group_location = "West us"
  address_space           = ["10.0.0.0/16"]

}

module "subnet" {
  depends_on           = [module.virtual_network]
  source               = "../child_modules/azurerm_subnet"
  subnet_name          = "aktestsubnet"
  resource_group_name  = "aktestrg"
  virtual_network_name = "aktestvnet"
  address_prefixes     = ["10.0.0.0/24"]
}

module "subnet1" {
  depends_on           = [module.virtual_network]
  source               = "../child_modules/azurerm_subnet"
  subnet_name          = "aktestsubnet1"
  resource_group_name  = "aktestrg"
  virtual_network_name = "aktestvnet"
  address_prefixes     = ["10.0.1.0/24"]
}
module "public_ip" {
  depends_on              = [module.resource_group]
  source                  = "../Child_modules/azurerm_public_ip"
  publicip                = "aktestpip"
  resource_group_name     = "aktestrg"
  resource_group_location = "West us"

}