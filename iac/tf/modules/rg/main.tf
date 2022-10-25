## variables
variable "base_name" {
  description = "Base name to use for the resources"
  type        = string
}

variable "location" {
  description = "region to deploy"
  type        = string
}
variable "tags" {
  description = "Tags"
  type        = map(string)
}

## outputs
output "rg" {
  value = ({
    id     = azurerm_resource_group.rg.id
    name   = local.rg_name
    region = var.location
  })
}

## locals
locals {
  rg_name = format("%s-rg", var.base_name)
}

## resources

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
}
