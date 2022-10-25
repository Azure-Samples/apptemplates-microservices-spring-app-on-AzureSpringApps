# Base Variables values pulled from ./variables.tfvars file if specified
# Can be set as variables set as GitHub secrets at action time

## variables
variable "base_name" {
  description = "Base name to use for the resources"
  type        = string
  default     = "random"
}

variable "location" {
  description = "Base region for the resources"
  type        = string
  default     = "eastus2"
}

variable "vnet_address_space" {
  type = string
  #  default = "10.1.0.0/16"
}

variable "app_subnet_address_space" {
  type = string
  # default = "10.1.0.0/24"
}

variable "service_subnet_address_space" {
  type = string
  #default = "10.1.1.0/24"
}

variable "dataservices_subnet_address_space" {
  type = string
  #default = "10.1.2.0/24"
}
variable "spring_cloud_reserved_ip_range" {
  description = "Comma-separated list of IP address ranges in CIDR format. The IP ranges are reserved to host underlying Azure Spring Cloud infrastructure, which should be 3 at least /16 unused IP ranges, must not overlap with any Subnet IP ranges"
  type        = list(string)
  #default = ["10.0.0.0/16", "10.2.0.0/16", "10.3.0.0/16"] 
}
variable "spring_cloud_service_name" {
  description = "The instance name of the Azure Spring Cloud resource"
  type        = string
  default     = "random"
}

variable "api_gateway_name" {
  type    = string
  default = "api-gateway"
}

variable "admin_server_name" {
  type    = string
  default = "admin-server"
}

variable "customers_service_name" {
  type    = string
  default = "customers-service"
}

variable "visits_service_name" {
  type    = string
  default = "visits-service"
}

variable "vets_service_name" {
  type    = string
  default = "vets-service"
}

variable "mysql_server_admin_name" {
  type    = string
  default = "sqlAdmin"
}

variable "mysql_server_admin_password" {
  type = string
}

variable "mysql_database_name" {
  type    = string
  default = "petclinic"
}
variable "time_zone_offset" {
  type    = string
  default = "-8:00"
}
variable "github_repo" {
  description = "GitHub repo to use for the config resources"
  type        = string
}

variable "github_repo_label" {
  description = "GitHub repo label to use for the config resources"
  type        = string
  default     = "main"
}
variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(any)
}
