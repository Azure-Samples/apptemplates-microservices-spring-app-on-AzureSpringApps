#Variables
variable "base_name" {
  description = "Base name to use for the resources"
  type        = string
}

variable "resource_group" {
  description = "The RG for the storage account"
  type = object({
    id     = string
    region = string
    name   = string
  })
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}

variable "vnet_address_space" {
  type = string
}

variable "app_subnet_address_space" {
  type = string
}

variable "service_subnet_address_space" {
  type = string
}

variable "dataservices_subnet_address_space" {
  type = string
}

# Outputs
output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "app_subnet" {
  value = azurerm_subnet.app_subnet
}

output "service_subnet" {
  value = azurerm_subnet.service_subnet
}

output "dataservices_subnet" {
  value = azurerm_subnet.dataservices_subnet
}


#Locals
locals {
  vnet_name = format("%s-vnet", var.base_name)
}


#Resources
resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.resource_group.region
  resource_group_name = var.resource_group.name
}

resource "azurerm_subnet" "app_subnet" {
  name                 = "app_subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.app_subnet_address_space]
}

resource "azurerm_subnet" "service_subnet" {
  name                 = "service_subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.service_subnet_address_space]
}

resource "azurerm_subnet" "dataservices_subnet" {
  name                 = "dataservices_subnet"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.dataservices_subnet_address_space]
}

resource "azurerm_role_assignment" "spring_cloud_admin_server_role_assignment" {
  scope                = azurerm_virtual_network.vnet.id
  role_definition_name = "Owner"
  principal_id         = "d2531223-68f9-459e-b225-5592f90d145e" #this is the Id of the Azure Spring Cloud RP
}

#TODO - Add NSGs
resource "azurerm_network_security_group" "app_subnet_nsg" {
  name                = "app_subnet_nsg"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.region

  # security_rule {
  # }
}

resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.app_subnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
}

resource "azurerm_network_security_group" "service_subnet_nsg" {
  name                = "service_subnet_nsg"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.region

  # security_rule {
  # }
}
resource "azurerm_subnet_network_security_group_association" "service_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.service_subnet.id
  network_security_group_id = azurerm_network_security_group.service_subnet_nsg.id
}

resource "azurerm_network_security_group" "dataservices_subnet_nsg" {
  name                = "dataservices_subnet_nsg"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.region

  # security_rule {
  # }
}
resource "azurerm_subnet_network_security_group_association" "dataservices_subnet_nsg_association" {
  subnet_id                 = azurerm_subnet.dataservices_subnet.id
  network_security_group_id = azurerm_network_security_group.dataservices_subnet_nsg.id
}
