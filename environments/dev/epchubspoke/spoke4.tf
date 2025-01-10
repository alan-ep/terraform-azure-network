# Define a spoke and associated resources
resource "azurerm_virtual_network" "spoke4_vnet" {
  name                = "vnet-spoke4-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.228.0.0/16"]
}

resource "azurerm_subnet" "spoke4_subnet" {
  name                 = "sn-spoke4-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke4_vnet.name
  address_prefixes     = ["10.228.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "spoke4_subnet_nsga" {
  subnet_id                 = azurerm_subnet.spoke4_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_manager_static_member" "spoke4_dev_vng" {
  name                      = "vnmsm-spoke4-dev-${var.prefix}-${var.env}-${var.location}"
  network_group_id          = azurerm_network_manager_network_group.dev_vng.id
  target_virtual_network_id = azurerm_virtual_network.spoke4_vnet.id
}

resource "azurerm_network_interface" "spoke4dev_nic" {
  name                = "spoke4dev-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.spoke4_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spoke4dev" {
  name                = "spoke4dev"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "Client"
    }
  )

  size           = "Standard_B2als_v2"
  admin_username = "adminuser"


  network_interface_ids = [
    azurerm_network_interface.spoke4dev_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("config/id_azure_epchubspoke.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}