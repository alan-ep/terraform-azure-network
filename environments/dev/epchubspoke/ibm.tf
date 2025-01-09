# Define a mock IBM site and associated resources
resource "azurerm_virtual_network" "ibm_vnet" {
  name                = "vnet-ibm-${var.prefix}-${var.env}-${var.location}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags

  address_space = ["10.239.0.0/16"]
}

resource "azurerm_subnet" "ibm_subnet" {
  name                 = "sn-ibm-${var.prefix}-${var.env}-${var.location}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.ibm_vnet.name
  address_prefixes     = ["10.239.0.0/24"]
}

resource "azurerm_subnet_network_security_group_association" "ibm_subnet_nsga" {
  subnet_id                 = azurerm_subnet.ibm_subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "ibmdev1_pip" {
  name                = "pip-ibmdev1-${var.prefix}-${var.env}-${var.location}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "ibmdev1_nic" {
  name                = "ibmdev1-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  accelerated_networking_enabled = true
  ip_forwarding_enabled          = true

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.ibm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.ibmdev1_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "ibmdev1" {
  name                = "ibmdev1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = var.tags

  size           = "Standard_F4s_v2"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.ibmdev1_nic.id,
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