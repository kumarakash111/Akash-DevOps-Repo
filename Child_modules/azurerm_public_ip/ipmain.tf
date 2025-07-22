resource "azurerm_public_ip" "piptest" {
  name                = var.publicip
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method   = "Static"

}
