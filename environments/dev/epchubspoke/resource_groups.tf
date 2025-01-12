resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.prefix}-${var.env}-${var.location}"
  location = var.location
  tags     = var.tags
}