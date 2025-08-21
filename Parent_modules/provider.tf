terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.35.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg_pipeline77"
    storage_account_name = "storagergpipeline77"
    container_name       = "containergpipeline77"
    key                  = "yamlpipeline77.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "972b29e5-b4b2-4f43-b814-02879737840d"
}