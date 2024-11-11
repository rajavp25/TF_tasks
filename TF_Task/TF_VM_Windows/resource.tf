
# instead of creating new resource group using existing Resource Group
data "azurerm_resource_group" "existing" {
  name = "TF_rsg"
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  resource_group_name = data.azurerm_resource_group.existing.name
  address_space       = var.add_space
  location            = var.location
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.sub_name
  resource_group_name  = data.azurerm_resource_group.existing.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subspace
}


resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = var.location
  resource_group_name = data.azurerm_resource_group.existing.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub1.id
  }
}
resource "azurerm_public_ip" "pub1" {
  name                = var.pubip
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = var.location
  allocation_method   = "Static"
}
resource "azurerm_windows_virtual_machine" "winvm" {
  name                = "TF-Win-VM"
  resource_group_name = data.azurerm_resource_group.existing.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.az_uname
  admin_password      = "Azureuser@123"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-pro"
    version   = "19045.4529.240607"
  }
}

# declaring output variables

output "public_ip" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_public_ip.pub1.ip_address
}
