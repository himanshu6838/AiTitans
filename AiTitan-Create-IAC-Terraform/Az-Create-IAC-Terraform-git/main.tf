/**
 * This Terraform configuration file defines the infrastructure for an Azure Stack project.
 * It includes the following modules:
 * - Networking: Creates a virtual network and subnets.
 * - Security Group: Configures security rules for the virtual network.
 * - Compute: Deploys virtual machines in the specified subnets.
 * - Database: Sets up a database with the specified configuration.
 *
 * The provider "azurerm" is used to interact with the Azure resources.
 * The data block "azurerm_resource_group" retrieves an existing resource group.
 *
 * Make sure to provide the necessary values for variables like location, vnetcidr, websubnetcidr, appsubnetcidr, dbsubnetcidr,
 * web_host_name, web_username, web_os_password, app_host_name, app_username, app_os_password, primary_database,
 * primary_database_version, primary_database_admin, and primary_database_password.
 */
provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# data block used for calling existing resource 

data "azurerm_resource_group" "rg-AiTItans-np" {
  name = "rg-AiTItans-np"
}

# Calling netwrok module to create virtual network and subnets 

module "networking" {
  source         = "./modules/networking"
  location       = var.location
  resource_group = data.azurerm_resource_group.rg-AiTItans-np.name
  vnetcidr       = var.vnetcidr
  websubnetcidr  = var.websubnetcidr
  appsubnetcidr  = var.appsubnetcidr
  dbsubnetcidr   = var.dbsubnetcidr
}


module "securitygroup" {
  source         = "./modules/securitygroup"
  location       = var.location
  resource_group = data.azurerm_resource_group.rg-AiTItans-np.name 
  web_subnet_id  = module.networking.websubnet_id
  app_subnet_id  = module.networking.appsubnet_id
  db_subnet_id   = module.networking.dbsubnet_id
}

module "compute" {
  source         = "./modules/compute"
  location = var.location
  resource_group = data.azurerm_resource_group.rg-AiTItans-np.name
  web_subnet_id = module.networking.websubnet_id
  app_subnet_id = module.networking.appsubnet_id
  web_host_name = var.web_host_name
  web_username = var.web_username
  web_os_password = var.web_os_password
  app_host_name = var.app_host_name
  app_username = var.app_username
  app_os_password = var.app_os_password
}

module "database" {
  source = "./modules/database"
  location = var.location
  resource_group = data.azurerm_resource_group.rg-AiTItans-np.name
  primary_database = var.primary_database
  primary_database_version = var.primary_database_version
  primary_database_admin = var.primary_database_admin
  primary_database_password = var.primary_database_password
}
