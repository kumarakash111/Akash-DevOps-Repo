data "azurerm_public_ip" "dada_publicip" {
  name                = "akkibublicip99"
  resource_group_name = "akkirg99"
}


data "azurerm_key_vault" "kv" {
  name                = "b17-g13-kv"
  resource_group_name = "rg-kv"
}

data "azurerm_key_vault_secret" "todo-vm-username" {
  name         = "todo-vm-username"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "todo-vm-password" {
  name         = "todo-vm-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_subnet" "datasubnet" {
  name                 = "akkisubnet99"
  virtual_network_name = "akkivnet99"
  resource_group_name  = "akkirg99"
}

resource "azurerm_network_interface" "akkinic" {
  name                = var.network_interface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.dada_publicip.id
  }
}
resource "azurerm_linux_virtual_machine" "akkivm" {
  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.size
  admin_username      = data.azurerm_key_vault_secret.todo-vm-username.value
  admin_password      = data.azurerm_key_vault_secret.todo-vm-password.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.akkinic.id,
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
    custom_data = base64encode(<<EOF
#!/bin/bash
apt-get update -y
apt-get install nginx -y
systemctl enable nginx
systemctl start nginx
EOF
  )
}