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
}

module "network" {
  source   = "../modules/network/"
  location = module.Resource_group.resource_group_location
  name     = module.Resource_Group.resource_group_name
}

