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

variable "time_zone_offset" {
  description = "Time zone offset in hours"
  type        = string
}

variable "mysql_server_admin_name" {
  type = string
}
variable "mysql_server_admin_password" {
  type = string
}
variable "mysql_database_name" {
  type = string
}

variable "tags" {
  description = "Tags"
  type        = map(any)
}

#outputs
output "id" {
  value = azurerm_mysql_server.mysql_server.id
}

output "fqdn" {
  value = azurerm_mysql_server.mysql_server.fqdn
}

#locals
locals {

}

#resources

resource "azurerm_mysql_server" "mysql_server" {
  name                = var.mysql_database_name
  location            = var.resource_group.region
  resource_group_name = var.resource_group.name

  sku_name                          = "GP_Gen5_2"
  storage_mb                        = 5120
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  version                           = "5.7"
  auto_grow_enabled                 = true
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = false
  #ssl_minimal_tls_version_enforced  = "TLS1_2"
  administrator_login          = var.mysql_server_admin_name
  administrator_login_password = var.mysql_server_admin_password
}

resource "azurerm_mysql_database" "mysqldb" {
  name                = var.mysql_database_name
  resource_group_name = var.resource_group.name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# resource "azurerm_mysql_firewall_rule" "allazureips" {
#   name                = "allAzureIPs"
#   resource_group_name = var.resource_group.name
#   server_name         = azurerm_mysql_server.mysql_server.name
#   start_ip_address    = "0.0.0.0"
#   end_ip_address      = "0.0.0.0"
# }


resource "azurerm_mysql_configuration" "example" {
  name                = "interactive_timeout"
  resource_group_name = var.resource_group.name
  server_name         = azurerm_mysql_server.mysql_server.name
  value               = "2147483"
}

resource "azurerm_mysql_configuration" "time_zone" {
  name                = "time_zone"
  resource_group_name = var.resource_group.name
  server_name         = azurerm_mysql_server.mysql_server.name
  value               = var.time_zone_offset // Add appropriate offset based on your region.
}
