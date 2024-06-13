terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.107.0"
    }
  }
}


provider "azurerm" {
  features {}
}

module "resource_group" {
  source   = "../modules/Resource_Group/"
  name     = "paas_resource_groupv2"
  type_iac = "PaaS"
}
module "container_app" {

  source      = "../modules/container_app/"
  rg_name     = module.resource_group.resource_group_name
  rg_location = module.resource_group.resource_group_location
}
