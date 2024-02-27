/**
 * Resource: azurerm_postgresql_server.primary
 * Description: This resource represents an Azure PostgreSQL server.
 * 
 * Parameters:
 * - name: The name of the PostgreSQL server.
 * - sku_name: The SKU name for the PostgreSQL server.
 * - resource_group_name: The name of the resource group in which to create the PostgreSQL server.
 * - location: The Azure region where the PostgreSQL server will be created.
 * - version: The version of PostgreSQL to use for the server.
 * - administrator_login: The administrator login name for the PostgreSQL server.
 * - administrator_login_password: The administrator login password for the PostgreSQL server.
 * - ssl_enforcement_enabled: Specifies whether SSL enforcement is enabled for the PostgreSQL server.
 * - ssl_minimal_tls_version_enforced: The minimum TLS version enforced for SSL connections to the PostgreSQL server.
 */
resource "azurerm_postgresql_server" "primary" {
    name = var.primary_database
    sku_name   = "GP_Gen5_4"
    resource_group_name = var.resource_group
    location = var.location
    version = var.primary_database_version
    administrator_login = var.primary_database_admin
    administrator_login_password = var.primary_database_password
    ssl_enforcement_enabled = true
    ssl_minimal_tls_version_enforced = "TLS1_2"
}
