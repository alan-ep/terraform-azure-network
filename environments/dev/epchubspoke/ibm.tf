# Define a mock IBM site and associated resources
resource "azurerm_virtual_network" "ibm_vnet" {
  name                = "vnet-ibm-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  address_space = ["10.239.0.0/16"]
}

resource "azurerm_subnet" "ibm_subnet" {
  name                 = "sn-ibm-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.ibm_vnet.name
  address_prefixes     = ["10.239.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "ibm_subnet_nsga" {
  subnet_id                 = azurerm_subnet.ibm_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}