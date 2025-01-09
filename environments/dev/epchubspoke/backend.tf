terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate-dev-eastus"
    storage_account_name = "stepcoretfstate"
    container_name       = "dev-tfstate"
    key                  = "dev.epsbhubspoke-eastus2.tfstate"
  }
}
