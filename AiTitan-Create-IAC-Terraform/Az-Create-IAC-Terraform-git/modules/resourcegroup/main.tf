/**
 * Creates an Azure resource group.
 * 
 * @resource {azurerm_resource_group} azure-stack-rs
 * @param {string} name - The name of the resource group.
 * @param {string} location - The location where the resource group will be created.
 */
resource "azurerm_resource_group" "azure-stack-rs" {
  name     = var.name
  location = var.location
}