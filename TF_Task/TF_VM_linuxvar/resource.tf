resource "azurerm_resource_group" "drs" {
  name     = "TF_rsg"
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  resource_group_name = azurerm_resource_group.drs.name
  address_space       = var.add_space
  location            = var.location
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.sub_name
  resource_group_name  = azurerm_resource_group.drs.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subspace
}
resource "azurerm_ssh_public_key" "ssh" {
  name                = "ssh_key"
  resource_group_name = azurerm_resource_group.drs.name
  location            = var.location
  public_key          = file("/home/dilli/.ssh/id_rsa.pub")

}

resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = var.location
  resource_group_name = azurerm_resource_group.drs.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pub1.id
  }
}
resource "azurerm_public_ip" "pub1" {
  name                = var.pubip
  resource_group_name = azurerm_resource_group.drs.name
  location            = var.location
  allocation_method   = "Static"
}
resource "azurerm_linux_virtual_machine" "linvm" {
  name                = "linuxvm02"
  resource_group_name = azurerm_resource_group.drs.name
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = var.az_uname
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
  admin_ssh_key {
    username   = var.az_uname
    public_key = azurerm_ssh_public_key.ssh.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

# declaring output variables

output "public_ip" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_public_ip.pub1.ip_address
}
