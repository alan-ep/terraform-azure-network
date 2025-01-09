# Define a spoke and associated resources
resource "azurerm_virtual_network" "spoke1_vnet" {
  name                = "vnet-spoke1-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  address_space = ["10.224.0.0/16"]
}

resource "azurerm_subnet" "spoke1_subnet" {
  name                 = "sn-spoke1-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke1_vnet.name
  address_prefixes     = ["10.224.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "spoke1_subnet_nsga" {
  subnet_id                 = azurerm_subnet.spoke1_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_manager_static_member" "spoke1_prod_vng" {
  name                      = "vnmsm-spoke1-prod-${var.prefix}-${var.env}-${var.location}"
  network_group_id          = azurerm_network_manager_network_group.prod_vng.id
  target_virtual_network_id = azurerm_virtual_network.spoke1_vnet.id
}