module "rg" {
  source      = "../child_module/azurerm_resource_group"
  rg_name     = "nannu-rg"
  rg_location = "west-us"
}


module "rg" {
  source      = "../child_module/azurerm_resource_group"
  for_each = var.resource_group_name
  rg_name     = each.value.name
  rg_location = each.value.location
}

module "storage_account" {
  depends_on      = [module.rg]
  for_each = var.storage_account_name
  source          = "../child_module/azurerm_storage_account"
  storage_account = each.value.name
  rg_name         = each.value.resource_group_name
  rg_location     = each.value.location
 
}

