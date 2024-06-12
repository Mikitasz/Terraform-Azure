terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.0.0"
    }
  }
}


provider "azurerm" {
  features {}
}

module "Resource_group" {
  source = "../modules/Resource_Group/"
  name 
}

