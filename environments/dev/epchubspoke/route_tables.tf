resource "azurerm_route_table" "hub_default" {
  name                = "rt-hub-default-${var.prefix}-${var.env}-${var.location}-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  bgp_route_propagation_enabled = true
}

resource "azurerm_route_table" "prod1_default" {
  name                = "rt-prod1-default-${var.prefix}-${var.env}-${var.location}-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  bgp_route_propagation_enabled = true
}

resource "azurerm_route_table" "prod2_default" {
  name                = "rt-prod2-default-${var.prefix}-${var.env}-${var.location}-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  bgp_route_propagation_enabled = true
}

resource "azurerm_route_table" "dev1_default" {
  name                = "rt-dev1-default-${var.prefix}-${var.env}-${var.location}-1"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  bgp_route_propagation_enabled = true
}