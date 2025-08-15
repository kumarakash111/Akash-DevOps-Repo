module "resource_group" {
  source                  = "../Child_modules/azurerm_resource_group"
  resource_group_name     = "aktestrg"
  resource_group_location = "West us"
}

module "resource_group1" {
  source                  = "../Child_modules/azurerm_resource_group"
  resource_group_name     = "rajtestrg"
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
  address_prefixes     = ["10.0.1.0/24"]
}

module "public_ip" {
  depends_on              = [module.resource_group]
  source                  = "../Child_modules/azurerm_public_ip"
  publicip                = "aktestpip"
  resource_group_name     = "aktestrg"
  resource_group_location = "West us"

}

module "azurerm_linux_virtual_machine" {
  depends_on              = [module.subnet, module.public_ip]
  source                  = "../Child_modules/azurerm_linux_vm"
  nic_name = "aktestnic"
  resource_group_name = "aktestrg"
  vm_name = "aktestvm"
  resource_group_location = "West us"

}