terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.35.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg_pipeline1"
    storage_account_name = "storagergpipeline1"
    container_name       = "containergpipeline1"
    key                  = "yamlpipeline.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = "0984a1bf-faa8-4fec-9405-7f354a86e020"
}