
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
  type        = map(any)
}

locals {
  log_analytics_name = format("%s-log-analytics", var.base_name)
  app_insights_name  = format("%s-app-insights", var.base_name)
}

resource "azurerm_log_analytics_workspace" "loganalytics" {
  name                = local.log_analytics_name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.region
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appanalytics" {
  name                = local.app_insights_name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.region
  application_type    = "java"
}
