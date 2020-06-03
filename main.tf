provider "azurerm" {
  version = "=2.9.0"
  subscription_id = "9112bec4-cc4b-48a1-80bc-94d387b25840"
  tenant_id = "edf442f5-b994-4c86-a131-b42b03a16c95"
  client_secret = "HHwAQtLIQ3CGDEHet54u6equgDaxcPBHl."
  client_id     = "199e404e-742d-401b-ae77-45beebf88b13"
  features {}
}

resource "azurerm_resource_group" "rgroup" {
  name     = var.rgroup
  location = var.location
}

resource "azurerm_virtual_network" "terraform_vnet" {
    name                = "${var.prefix}-vnet"
    location            = var.location
    resource_group_name = azurerm_resource_group.rgroup.name
    address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "webserver_subnet" {
    name                 = var.web_server_subnet_name
    resource_group_name  = azurerm_resource_group.rgroup.name
    virtual_network_name = azurerm_virtual_network.terraform_vnet.name
    address_prefix       = var.web_server_subnet_address_space
}

