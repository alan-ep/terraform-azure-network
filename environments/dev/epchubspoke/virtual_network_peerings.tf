resource "azurerm_virtual_network_peering" "hub_prod1" {
  name                = "peer-prod1-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.prod1.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "hub_prod2" {
  name                = "peer-prod2-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.prod2.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "hub_dev1" {
  name                = "peer-dev1-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.hub.name
  remote_virtual_network_id = azurerm_virtual_network.dev1.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "prod1_hub" {
  name                = "peer-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.prod1.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true

  depends_on = [
    azurerm_virtual_network_peering.hub_prod1
  ]
}

resource "azurerm_virtual_network_peering" "prod1_prod2" {
  name                = "peer-prod2-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.prod1.name
  remote_virtual_network_id = azurerm_virtual_network.prod2.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "prod2_hub" {
  name                = "peer-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.prod2.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true

  depends_on = [
    azurerm_virtual_network_peering.hub_prod2
  ]
}

resource "azurerm_virtual_network_peering" "prod2_prod1" {
  name                = "peer-prod1-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.prod2.name
  remote_virtual_network_id = azurerm_virtual_network.prod1.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "dev1_hub" {
  name                = "peer-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name

  virtual_network_name      = azurerm_virtual_network.dev1.name
  remote_virtual_network_id = azurerm_virtual_network.hub.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true

  depends_on = [
    azurerm_virtual_network_peering.hub_dev1
  ]
}