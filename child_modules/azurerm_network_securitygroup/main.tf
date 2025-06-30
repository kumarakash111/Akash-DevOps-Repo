data "azurerm_network_interface" "data_nic" {
  name                = "akkivmnic99"
  resource_group_name = "akkirg99"
}

data "azurerm_network_security_group" "data_nsg" {
  name                = "akkinsg99"
  resource_group_name = "akkirg99"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "akkinsg99"
  location            = "East US"
  resource_group_name = "akkirg99"

  security_rule {
    name                       = "security_rule_ssh"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = data.azurerm_network_interface.data_nic.id
  network_security_group_id = data.azurerm_network_security_group.data_nsg.id
}

