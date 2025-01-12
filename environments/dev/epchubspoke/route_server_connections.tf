resource "azurerm_route_server_bgp_connection" "nvawgdev1" {
  name            = "con-nvawgdev1-${var.prefix}-${var.env}-${var.location}"
  route_server_id = azurerm_route_server.hub.id
  peer_asn        = 64522
  peer_ip         = "10.224.3.4"
}

resource "azurerm_route_server_bgp_connection" "nvawgdev2" {
  name            = "con-nvawgdev2-${var.prefix}-${var.env}-${var.location}"
  route_server_id = azurerm_route_server.hub.id
  peer_asn        = 64522
  peer_ip         = "10.224.3.5"
}