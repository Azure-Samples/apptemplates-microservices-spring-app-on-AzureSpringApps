

## outputs
output "db_password" {
  value     = local.db_password
  sensitive = true
}

## locals
locals {
  base_name                 = var.base_name == "random" ? random_string.base_id.result : var.base_name
  db_name                   = format("%s-%s", var.mysql_database_name, local.base_name)
  db_password               = var.mysql_server_admin_password == "random" ? random_password.default.result : var.mysql_server_admin_password
  spring_cloud_service_name = var.spring_cloud_service_name == "random" ? random_string.base_id.result : var.spring_cloud_service_name
}

## resources

resource "random_string" "base_id" {
  length  = 5
  special = false
  upper   = false
  number  = true
}

resource "random_password" "default" {
  length  = 33
  special = true
}

# Base Resource group
module "base_rg" {
  source    = "./modules/rg"
  base_name = local.base_name
  location  = var.location
  tags      = var.tags
}

# VNet
module "vnet" {
  source                            = "./modules/network"
  base_name                         = local.base_name
  resource_group                    = module.base_rg.rg
  vnet_address_space                = var.vnet_address_space
  app_subnet_address_space          = var.app_subnet_address_space
  service_subnet_address_space      = var.service_subnet_address_space
  dataservices_subnet_address_space = var.dataservices_subnet_address_space
  tags                              = var.tags
}

# Monitor
module "monitor" {
  source         = "./modules/monitor"
  base_name      = local.base_name
  resource_group = module.base_rg.rg
  tags           = var.tags
}

# MySQL DB
module "mysql" {
  source                      = "./modules/mysql"
  base_name                   = local.base_name
  resource_group              = module.base_rg.rg
  time_zone_offset            = var.time_zone_offset
  mysql_server_admin_name     = var.mysql_server_admin_name
  mysql_server_admin_password = local.db_password
  mysql_database_name         = local.db_name
  tags                        = var.tags
}

# Spring Cloud Service
module "springcloud" {
  source                         = "./modules/springcloud"
  base_name                      = local.base_name
  resource_group                 = module.base_rg.rg
  app_subnet                     = module.vnet.app_subnet
  service_subnet                 = module.vnet.service_subnet
  spring_cloud_reserved_ip_range = var.spring_cloud_reserved_ip_range
  spring_cloud_service_name      = local.spring_cloud_service_name
  api_gateway_name               = var.api_gateway_name
  admin_server_name              = var.admin_server_name
  customers_service_name         = var.customers_service_name
  visits_service_name            = var.visits_service_name
  vets_service_name              = var.vets_service_name
  github_repo                    = var.github_repo
  github_repo_label              = var.github_repo_label
  tags                           = var.tags
}









