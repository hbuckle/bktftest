terraform {
  backend "azurerm" {
    storage_account_name = "qifoghtnvyauqtr"
    container_name       = "tfstate"
    key                  = "bktftest"
  }
}

resource "azurerm_resource_group" "resource_group" {
  name     = "test"
  location = "northeurope"
}
