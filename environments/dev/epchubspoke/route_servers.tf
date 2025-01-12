resource "azurerm_route_server" "hub" {
  name                = "rtserv-hub-${var.prefix}-${var.env}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku                              = "Standard"
  public_ip_address_id             = azurerm_public_ip.rtserv.id
  subnet_id                        = azurerm_subnet.hub_rtserv.id
  branch_to_branch_traffic_enabled = true
}