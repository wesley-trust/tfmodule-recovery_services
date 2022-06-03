# Recovery services vault for solution
resource "azurerm_recovery_services_vault" "recovery_services_vault" {
  depends_on = [
    time_sleep.wait_30_seconds
  ]
  name                = "${local.resource_name}-vault"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  sku                 = "Standard"

  soft_delete_enabled = false
}
