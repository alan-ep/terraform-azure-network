resource "azurerm_subnet_network_security_group_association" "hub_wg" {
  subnet_id                 = azurerm_subnet.hub_wg.id
  network_security_group_id = azurerm_network_security_group.hub_default.id
}

resource "azurerm_subnet_network_security_group_association" "prod1_client" {
  subnet_id                 = azurerm_subnet.prod1_client.id
  network_security_group_id = azurerm_network_security_group.prod1_default.id
}

resource "azurerm_subnet_network_security_group_association" "prod2_client" {
  subnet_id                 = azurerm_subnet.prod2_client.id
  network_security_group_id = azurerm_network_security_group.prod2_default.id
}

resource "azurerm_subnet_network_security_group_association" "dev1_client" {
  subnet_id                 = azurerm_subnet.dev1_client.id
  network_security_group_id = azurerm_network_security_group.dev1_default.id
}

resource "azurerm_subnet_network_security_group_association" "ibm_wg" {
  subnet_id                 = azurerm_subnet.ibm_wg.id
  network_security_group_id = azurerm_network_security_group.ibm_default.id
}
