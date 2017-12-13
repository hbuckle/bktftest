provider "azurerm" {}

resource "azurerm_resource_group" "resource_group" {
  name     = "test"
  location = "${var.location}"
}
