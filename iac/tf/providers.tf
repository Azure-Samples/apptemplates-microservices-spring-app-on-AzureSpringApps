terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.91.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "=1.3.0"
    }
  }
}

# Configure the Microsoft Azure Providers
provider "azurerm" {
  features {}
}
provider "azuread" {

}
