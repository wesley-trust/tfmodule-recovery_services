# Delay destroy by 30 seconds, to allow for service replication
resource "time_sleep" "wait_30_seconds" {
  depends_on = [azurerm_recovery_services_vault.recovery_services_vault]

  destroy_duration = "30s"
}
