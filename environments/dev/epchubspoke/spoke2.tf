# Define a spoke and associated resources
resource "azurerm_virtual_network" "spoke2_vnet" {
  name                = "vnet-spoke2-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  address_space = ["10.225.0.0/16"]
}

resource "azurerm_subnet" "spoke2_subnet" {
  name                 = "sn-spoke2-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke2_vnet.name
  address_prefixes     = ["10.225.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "spoke2_subnet_nsga" {
  subnet_id                 = azurerm_subnet.spoke2_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_manager_static_member" "spoke2_prod_vng" {
  name                      = "vnmsm-spoke2-prod-${var.prefix}-${var.env}-${var.location}"
  network_group_id          = azurerm_network_manager_network_group.prod_vng.id
  target_virtual_network_id = azurerm_virtual_network.spoke2_vnet.id
}