# Backup policy
resource "azurerm_backup_policy_vm" "backup_policy_vm" {
  depends_on          = [azurerm_recovery_services_vault.recovery_services_vault]
  name                = "${local.resource_name}-policy"
  resource_group_name = module.resource_group.name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_services_vault.name

  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "00:00"
  }

  retention_daily {
    count = 7
  }

  retention_weekly {
    count    = 4
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = 12
    weekdays = ["Sunday"]
    weeks    = ["Last"]
  }

  retention_yearly {
    count    = 1
    weekdays = ["Sunday"]
    weeks    = ["Last"]
    months   = ["December"]
  }
}

# Automatically backup virtual machine
resource "azurerm_backup_protected_vm" "backup_protected_vm" {
  depends_on = [
    azurerm_backup_policy_vm.backup_policy_vm,
    azurerm_recovery_services_vault.recovery_services_vault
  ]
  count               = var.resource_automatic_backups_enabled == true ? var.resource_recovery_services_instance_count : 0
  resource_group_name = module.resource_group.name
  recovery_vault_name = azurerm_recovery_services_vault.recovery_services_vault.name
  source_vm_id        = var.resource_recovery_services_virtual_machines.virtual_machine_id[count.index]
  backup_policy_id    = azurerm_backup_policy_vm.backup_policy_vm.id
}
