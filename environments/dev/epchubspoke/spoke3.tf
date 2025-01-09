# Define a spoke and associated resources
resource "azurerm_virtual_network" "spoke3_vnet" {
  name                = "vnet-spoke3-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  address_space = ["10.226.0.0/16"]
}

resource "azurerm_subnet" "spoke3_subnet" {
  name                 = "sn-spoke3-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke3_vnet.name
  address_prefixes     = ["10.226.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "spoke3_subnet_nsga" {
  subnet_id                 = azurerm_subnet.spoke3_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_manager_static_member" "spoke3_dev_vng" {
  name                      = "vnmsm-spoke3-dev-${var.prefix}-${var.env}-${var.location}"
  network_group_id          = azurerm_network_manager_network_group.dev_vng.id
  target_virtual_network_id = azurerm_virtual_network.spoke3_vnet.id
}