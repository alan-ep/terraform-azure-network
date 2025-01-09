# Define a hub and associated resources
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  address_space = ["10.223.0.0/16"]
}

resource "azurerm_subnet" "hub_subnet" {
  name                 = "sn-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.223.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "hub_subnet_nsga" {
  subnet_id                 = azurerm_subnet.hub_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_manager" "hub_vnm" {
  name                = "vnm-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  scope {
    subscription_ids = [data.azurerm_subscription.current.id]
  }
  scope_accesses = ["Connectivity", "Routing", "SecurityAdmin"]
}

resource "azurerm_network_manager_network_group" "prod_vng" {
  name               = "vng-prod-${var.prefix}-${var.env}-${var.location}"
  network_manager_id = azurerm_network_manager.hub_vnm.id
}

resource "azurerm_network_manager_network_group" "dev_vng" {
  name               = "vng-dev-${var.prefix}-${var.env}-${var.location}"
  network_manager_id = azurerm_network_manager.hub_vnm.id
}

resource "azurerm_network_manager_connectivity_configuration" "hub_vnc" {
  name                  = "vnc-hub-${var.prefix}-${var.env}-${var.location}"
  network_manager_id    = azurerm_network_manager.hub_vnm.id
  connectivity_topology = "HubAndSpoke"

  applies_to_group {
    group_connectivity  = "DirectlyConnected"
    network_group_id    = azurerm_network_manager_network_group.prod_vng.id
    global_mesh_enabled = true
    use_hub_gateway     = true
  }

  applies_to_group {
    group_connectivity  = "DirectlyConnected"
    network_group_id    = azurerm_network_manager_network_group.dev_vng.id
    global_mesh_enabled = true
    use_hub_gateway     = true
  }

  hub {
    resource_id   = azurerm_virtual_network.hub_vnet.id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

resource "azurerm_network_manager_deployment" "hub_vnc_deployment" {
  network_manager_id = azurerm_network_manager.hub_vnm.id
  location           = azurerm_resource_group.rg.location
  scope_access       = "Connectivity"
  configuration_ids  = [azurerm_network_manager_connectivity_configuration.hub_vnc.id]
}