resource "azurerm_storage_account" "stg11" {
  name                     = var.storage_account
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}