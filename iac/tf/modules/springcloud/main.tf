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
variable "app_subnet" {
  description = "The address space for the app subnet"
  type = object({
    id               = string
    address_prefixes = list(string)
  })
}

variable "service_subnet" {
  description = "The address space for the service subnet"
  type = object({
    id               = string
    address_prefixes = list(string)
  })
}
variable "spring_cloud_reserved_ip_range" {
  description = "The address space for the spring cloud reserved ip range"
  type        = list(string)
}

variable "spring_cloud_service_name" {
  description = "The name of the spring cloud service"
  type        = string
}
variable "api_gateway_name" {
  description = "The name of the api gateway"
  type        = string
}
variable "admin_server_name" {
  description = "The name of the admin server"
  type        = string
}
variable "customers_service_name" {
  description = "The name of the customers service"
  type        = string
}

variable "visits_service_name" {
  description = "The name of the visits service"
  type        = string
}
variable "vets_service_name" {
  description = "The name of the vets service"
  type        = string
}

variable "github_repo" {
  description = "The name of the github repo"
  type        = string
}

variable "github_repo_label" {
  description = "The label of the github repo"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}


# Locals
locals {
}


# Resources
resource "azurerm_spring_cloud_service" "spring_cloud" {
  name                = var.spring_cloud_service_name
  resource_group_name = var.resource_group.name
  location            = var.resource_group.region
  sku_name            = "S0"


  config_server_git_setting {
    uri          = var.github_repo
    label        = var.github_repo_label
    search_paths = ["."]
  }

  network {
    app_subnet_id             = var.app_subnet.id
    service_runtime_subnet_id = var.service_subnet.id
    cidr_ranges               = var.spring_cloud_reserved_ip_range
  }

  tags = var.tags
}

resource "azurerm_spring_cloud_app" "api_gateway" {
  name                = var.api_gateway_name
  resource_group_name = var.resource_group.name
  service_name        = azurerm_spring_cloud_service.spring_cloud.name
}


resource "azurerm_spring_cloud_app" "admin_server" {
  name                = var.admin_server_name
  resource_group_name = var.resource_group.name
  service_name        = azurerm_spring_cloud_service.spring_cloud.name
}

resource "azurerm_spring_cloud_app" "customers_service" {
  name                = var.customers_service_name
  resource_group_name = var.resource_group.name
  service_name        = azurerm_spring_cloud_service.spring_cloud.name
}

resource "azurerm_spring_cloud_app" "vets_service" {
  name                = var.vets_service_name
  resource_group_name = var.resource_group.name
  service_name        = azurerm_spring_cloud_service.spring_cloud.name
}

resource "azurerm_spring_cloud_app" "visits_service" {
  name                = var.visits_service_name
  resource_group_name = var.resource_group.name
  service_name        = azurerm_spring_cloud_service.spring_cloud.name
}

# resource "azurerm_monitor_diagnostic_setting" "sc_diag" {
#   name                        = "monitoring"
#   target_resource_id          = azurerm_spring_cloud_service.sc.id
#   log_analytics_workspace_id = "/subscriptions/${var.subscription}/resourceGroups/${var.azurespringcloudvnetrg}/providers/Microsoft.OperationalInsights/workspaces/${var.sc_law_id}"

#   log {
#     category = "ApplicationConsole"
#     enabled  = true

#     retention_policy {
#       enabled = false
#     }
#   }

#   metric {
#     category = "AllMetrics"

#     retention_policy {
#       enabled = false
#     }
#   }
# }
