module "recovery_services" {
  depends_on                                  = [module.compute]
  for_each                                    = toset(var.service_location)
  source                                      = "../"
  service_environment                         = var.service_environment
  service_deployment                          = var.service_deployment
  service_name                                = "${var.service_name}-RSV"
  service_location                            = each.value
  resource_name                               = local.resource_name
  resource_recovery_services_instance_count   = var.resource_instance_count
  resource_recovery_services_virtual_machines = module.compute[each.value]
  resource_automatic_backups_enabled          = var.resource_automatic_backups_enabled
  resource_delete_protection_enabled          = var.resource_delete_protection_enabled
}
