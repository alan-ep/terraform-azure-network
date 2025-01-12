resource "azurerm_linux_virtual_machine" "nvawgdev1" {
  name                = "nvawgdev1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "NvaWg"
    }
  )

  size           = "Standard_F4s_v2"
  zone           = "1"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.nvawgdev1.id,
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

resource "azurerm_linux_virtual_machine" "nvawgdev2" {
  name                = "nvawgdev2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "NvaWg"
    }
  )

  size           = "Standard_F4s_v2"
  zone           = "2"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.nvawgdev2.id,
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

resource "azurerm_linux_virtual_machine" "prod1clientdev" {
  name                = "prod1clientdev"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "Client"
    }
  )

  size           = "Standard_B2als_v2"
  zone           = "1"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.prod1clientdev.id,
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

resource "azurerm_linux_virtual_machine" "prod2clientdev" {
  name                = "prod2clientdev"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "Client"
    }
  )

  size           = "Standard_B2als_v2"
  zone           = "1"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.prod2clientdev.id,
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

resource "azurerm_linux_virtual_machine" "dev1clientdev" {
  name                = "dev1clientdev"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "Client"
    }
  )

  size           = "Standard_B2als_v2"
  zone           = "1"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.dev1clientdev.id,
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

resource "azurerm_linux_virtual_machine" "ibmwgdev1" {
  name                = "ibmwgdev1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags = merge(
    azurerm_resource_group.rg.tags,
    {
      role = "IbmWg"
    }
  )

  size           = "Standard_F4s_v2"
  zone           = "1"
  admin_username = "adminuser"

  network_interface_ids = [
    azurerm_network_interface.ibmwgdev1.id,
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
