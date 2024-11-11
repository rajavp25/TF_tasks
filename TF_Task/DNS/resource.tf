# instead of creating new resource group using existing Resource Group using data source

data "azurerm_resource_group" "existing" {
  name = "TF_rsg"
}

resource "azurerm_virtual_network" "dvn1" {
  name                = "N1"
  resource_group_name = data.azurerm_resource_group.existing.name
  address_space       = ["10.0.6.0/24"]
  location            = var.location
}

resource "azurerm_virtual_network" "dvn2" {
  name                = "N2"
  resource_group_name = data.azurerm_resource_group.existing.name
  address_space       = ["10.0.7.0/24"]
  location            = var.location
}

resource "azurerm_virtual_network_peering" "dvn1" {
  name                      = "PN1to2"
  resource_group_name       = data.azurerm_resource_group.existing.name
  virtual_network_name      = azurerm_virtual_network.dvn1.name
  remote_virtual_network_id = azurerm_virtual_network.dvn2.id
}

resource "azurerm_virtual_network_peering" "dvn2" {
  name                      = "PN2to1"
  resource_group_name       = data.azurerm_resource_group.existing.name
  virtual_network_name      = azurerm_virtual_network.dvn2.name
  remote_virtual_network_id = azurerm_virtual_network.dvn1.id
}

# Create a Private DNS Zone
resource "azurerm_private_dns_zone" "pdnszone" {
  name                = "vpm.com"
  resource_group_name = data.azurerm_resource_group.existing.name
}

resource "azurerm_private_dns_a_record" "spip" {
  name                = "service"
  zone_name           = azurerm_private_dns_zone.pdnszone.name
  resource_group_name = data.azurerm_resource_group.existing.name
  ttl                 = 300
  records             = ["10.2.0.5"]
}

