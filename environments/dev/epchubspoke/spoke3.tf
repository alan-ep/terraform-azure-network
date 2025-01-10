# Define a spoke and associated resources
resource "azurerm_virtual_network" "spoke3_vnet" {
  name                = "vnet-spoke3-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = azurerm_resource_group.rg.tags

  address_space = ["10.227.0.0/16"]
}

resource "azurerm_subnet" "spoke3_subnet" {
  name                 = "sn-spoke3-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.spoke3_vnet.name
  address_prefixes     = ["10.227.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "spoke3_subnet_nsga" {
  subnet_id                 = azurerm_subnet.spoke3_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_manager_static_member" "spoke3_dev_vng" {
  name                      = "vnmsm-spoke3-dev-${var.prefix}-${var.env}-${var.location}"
  network_group_id          = azurerm_network_manager_network_group.dev_vng.id
  target_virtual_network_id = azurerm_virtual_network.spoke3_vnet.id
}

resource "azurerm_network_interface" "spoke3dev_nic" {
  name                = "spoke3dev-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = azurerm_resource_group.rg.tags

  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.spoke3_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "spoke3dev" {
  name                = "spoke3dev"
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
    azurerm_network_interface.spoke3dev_nic.id,
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