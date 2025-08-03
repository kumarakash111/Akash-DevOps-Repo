data "azurerm_subnet" "datasubnet" {
  name                 = "aktestsubnet"
  virtual_network_name = "aktestvnet"
  resource_group_name  = "aktestrg"
}

data "azurerm_public_ip" "datapublicip" {
  name                = "aktestpip"
  resource_group_name = "aktestrg"
}

data "azurerm_key_vault" "keyvault" {
  name                = "b17-g13-keyVault"
  resource_group_name = "KeyVaultRg"
}

data "azurerm_key_vault_secret" "todo-vm-username" {
  name         = "todo-vm-username"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "todo-vm-password" {
  name         = "todo-vm-password"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}


resource "azurerm_network_interface" "networkinterface" {
  name                = var.nic_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.datapublicip.id
  }
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = "Standard_F2"
  admin_username      = data.azurerm_key_vault_secret.todo-vm-username.value
  admin_password      = data.azurerm_key_vault_secret.todo-vm-password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.networkinterface.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}