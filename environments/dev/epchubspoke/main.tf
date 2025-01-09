# Define shared resources
data "azurerm_subscription" "current" {
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-${var.env}-${var.location}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-${var.prefix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  security_rule {
    name                       = "AllowAll"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}