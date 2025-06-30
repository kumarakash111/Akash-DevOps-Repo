# adding one more resoiurce group to the module
# This module creates an Azure Resource Group


resource "azurerm_resource_group" "akkirg33" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_resource_group" "akkirg" {
  name     = var.resource_group_name
  location = var.location
}
