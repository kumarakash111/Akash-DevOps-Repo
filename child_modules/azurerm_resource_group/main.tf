# adding one more resoiurce group to the module
# This module creates an Azure Resource Group
#addinng one more resource group to the module
# This module creates an Azure Resource Group
# Adding this line only to make a change

resource "azurerm_resource_group" "akkirg33" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_resource_group" "akkirg33" {
  name     = var.resource_group_name
  location = var.location
}


resource "azurerm_resource_group" "akkirg" {
  name     = var.resource_group_name
  location = var.location
}
