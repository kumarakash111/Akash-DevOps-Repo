resource "azurerm_resource_group" "akkirg" {
  name     = var.resource_group_name
  location = var.location
}
