resource "azurerm_subnet_route_table_association" "hub_wg" {
  subnet_id      = azurerm_subnet.hub_wg.id
  route_table_id = azurerm_route_table.hub_default.id
}

resource "azurerm_subnet_route_table_association" "prod1_client" {
  subnet_id      = azurerm_subnet.prod1_client.id
  route_table_id = azurerm_route_table.prod1_default.id
}

resource "azurerm_subnet_route_table_association" "prod2_client" {
  subnet_id      = azurerm_subnet.prod2_client.id
  route_table_id = azurerm_route_table.prod2_default.id
}

resource "azurerm_subnet_route_table_association" "dev1_client" {
  subnet_id      = azurerm_subnet.dev1_client.id
  route_table_id = azurerm_route_table.dev1_default.id
}

resource "azurerm_subnet_route_table_association" "ibm_wg" {
  subnet_id      = azurerm_subnet.ibm_wg.id
  route_table_id = azurerm_route_table.ibm_default.id
}