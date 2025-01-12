resource "azurerm_subnet" "hub_rtserv" {
  name                 = "RouteServerSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.224.0.0/24"]
}

resource "azurerm_subnet" "hub_gw" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.224.1.0/24"]
}

resource "azurerm_subnet" "hub_afw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.224.2.0/24"]
}

resource "azurerm_subnet" "hub_wg" {
  name                 = "sn-wg-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  address_prefixes     = ["10.224.3.0/24"]
}

resource "azurerm_subnet" "prod1_client" {
  name                 = "sn-client-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.prod1.name
  address_prefixes     = ["10.225.0.0/24"]
}

resource "azurerm_subnet" "prod2_client" {
  name                 = "sn-client-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.prod2.name
  address_prefixes     = ["10.226.0.0/24"]
}

resource "azurerm_subnet" "dev1_client" {
  name                 = "sn-client-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.dev1.name
  address_prefixes     = ["10.227.0.0/24"]
}

resource "azurerm_subnet" "ibm_wg" {
  name                 = "sn-wg-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.ibm.name
  address_prefixes     = ["10.223.0.0/24"]
}