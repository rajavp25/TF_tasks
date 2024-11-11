
# using under terraform block using azure provider

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

}

# using the existing resource group using data source

data "azurerm_resource_group" "existing" {
name = "TF_rsg"
}

# using the azure container registyr code block

resource "azurerm_container_registry" "azcr" {
  name                = "azccr1"
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = "westus2"
  sku                 = "Basic"
  admin_enabled       = true
}


