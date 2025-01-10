# Define a hub and associated resources
resource "azurerm_virtual_network" "hub_vnet" {
  name                = "vnet-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.224.0.0/16"]
}

resource "azurerm_subnet" "hub_subnet" {
  name                 = "sn-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.224.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "hub_subnet_nsga" {
  subnet_id                 = azurerm_subnet.hub_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_manager" "hub_vnm" {
  name                = "vnm-hub-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

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

resource "azurerm_public_ip" "hubdev1_pip" {
  name                = "pip-hubdev1-${var.prefix}-${var.env}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = azurerm_resource_group.rg.tags
}

resource "azurerm_network_interface" "hubdev1_nic" {
  name                = "hubdev1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.hub_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.hubdev1_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "hubdev1" {
  name                = "hubdev1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "Server"
    }
  )

  size           = "Standard_F4s_v2"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.hubdev1_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("config/id_azure_epchubspoke.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}