resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.224.0.0/16"]
}

resource "azurerm_virtual_network" "prod1" {
  name                = "vnet-prod1-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.225.0.0/16"]
}

resource "azurerm_virtual_network" "prod2" {
  name                = "vnet-prod2-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.226.0.0/16"]
}

resource "azurerm_virtual_network" "dev1" {
  name                = "vnet-dev1-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.227.0.0/16"]
}

resource "azurerm_virtual_network" "ibm" {
  name                = "vnet-ibm-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.223.0.0/16"]
}