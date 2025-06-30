module "resource_group" {
  source              = "../child_modules/azurerm_resource_group"
  resource_group_name = "akkirg99"
  location            = "East US"
}

module "virtual_network" {
  source               = "../child_modules/azurerm_virtual_network"
  depends_on           = [module.resource_group]
  virtual_network_name = "akkivnet99"
  location             = "East US"
  resource_group_name  = "akkirg99"
  address_space        = ["10.0.0.0/16"]
}

module "subnet" {
  depends_on           = [module.virtual_network]
  source               = "../child_modules/azurerm_subnet"
  subnet_name          = "akkisubnet99"
  resource_group_name  = "akkirg99"
  virtual_network_name = "akkivnet99"
  address_prefix       = ["10.0.1.0/24"]
}

module "public_ip" {
  depends_on          = [module.resource_group]
  source              = "../child_modules/azurerm_public_ip"
  public_ip_name      = "akkibublicip99"
  resource_group_name = "akkirg99"
  location            = "East US"
  allocation_method   = "Static"

}

module "linux_vm" {
  depends_on             = [module.subnet, module.public_ip]
  source                 = "../child_modules/azurerm_linux_vm"
  network_interface_name = "akkivmnic99"
  location               = "East US"
  resource_group_name    = "akkirg99"
  virtual_machine_name   = "akkivm99"
  size                   = "Standard_B1s"
}

module "azurerm_network_security_group" {
  source = "../child_modules/azurerm_network_securitygroup"

}



