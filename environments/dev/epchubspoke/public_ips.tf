resource "azurerm_public_ip" "rtserv" {
  name                = "pip-rtserv-${var.prefix}-${var.env}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"
  tags              = azurerm_resource_group.rg.tags
}

resource "azurerm_public_ip" "nvawgdev1" {
  name                = "pip-nvawgdev1-${var.prefix}-${var.env}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"
  tags              = azurerm_resource_group.rg.tags
}

resource "azurerm_public_ip" "nvawgdev2" {
  name                = "pip-nvawgdev2-${var.prefix}-${var.env}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"
  tags              = azurerm_resource_group.rg.tags
}

resource "azurerm_public_ip" "ibmwgdev1" {
  name                = "pip-ibmwgdev1-${var.prefix}-${var.env}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  allocation_method = "Static"
  sku               = "Standard"
  tags              = azurerm_resource_group.rg.tags
}