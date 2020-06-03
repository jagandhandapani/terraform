provider "azurerm" {
  version = "=2.9.0"
  subscription_id = "9112bec4-cc4b-48a1-80bc-94d387b25840"
  tenant_id = "edf442f5-b994-4c86-a131-b42b03a16c95"
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

resource "azurerm_network_interface" "networkinterface" {
    count               = var.webserver_count
    name                = "${var.web_network_interface}-${format("%02d",count.index)}"
    location            = var.location
    resource_group_name = azurerm_resource_group.rgroup.name

    ip_configuration {
        name                          = "testConfiguration"
        subnet_id                     = azurerm_subnet.webserver_subnet.id
        private_ip_address_allocation = "dynamic"
        public_ip_address_id          =  element(azurerm_public_ip.webserver_public_ip.*.id, count.index)
 }
}

resource "azurerm_public_ip" "webserver_public_ip" {
    count                = var.webserver_count
    name                 = "${var.public_ip}-${format("%02d",count.index)}"
    location             = var.location
    resource_group_name  = azurerm_resource_group.rgroup.name
    allocation_method    = "Dynamic"
}


resource "azurerm_windows_virtual_machine" "windows_vm"{
    count                        = var.webserver_count
    name                         = "${var.prefix}-${format("%02d",count.index)}"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.rgroup.name
    network_interface_ids        = [element(azurerm_network_interface.networkinterface.*.id, count.index)]
    size                         = "Standard_B1s"
    admin_username               = "jaganazure"
    admin_password               = "Security@321"

    os_disk {
        caching     = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }
    source_image_reference {
        publisher       = "MicrosoftWindowsServer"
        offer           = "WindowsServerSemiAnnual"
        sku             = "Datacenter-Core-1709-smalldisk"
        version         = "latest"
    }
}

