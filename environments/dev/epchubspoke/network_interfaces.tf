resource "azurerm_network_interface" "nvawgdev1" {
  name                = "nvawgdev1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub_wg.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.224.3.4"
    public_ip_address_id          = azurerm_public_ip.nvawgdev1.id
  }
}

resource "azurerm_network_interface" "nvawgdev2" {
  name                = "nvawgdev2-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub_wg.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.224.3.5"
    public_ip_address_id          = azurerm_public_ip.nvawgdev2.id
  }
}

resource "azurerm_network_interface" "prod1clientdev" {
  name                = "prod1dev-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prod1_client.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "prod2clientdev" {
  name                = "prod2dev-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prod2_client.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "dev1clientdev" {
  name                = "dev1dev-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev1_client.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "ibmwgdev1" {
  name                = "ibmwgdev1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ibm_wg.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.223.0.4"
    public_ip_address_id          = azurerm_public_ip.ibmwgdev1.id
  }
}