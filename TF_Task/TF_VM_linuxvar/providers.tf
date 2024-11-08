terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.8.0"
    }
  }
}

provider "azurerm" {

features {}
  subscription_id = "00000"
  client_id       = "00000"
  client_secret   = "00000"
  tenant_id       = "00000"
}

