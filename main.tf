locals {
  master_instance_name     = "${var.name}-${random_id.suffix.hex}"
  ip_configuration_enabled = length(keys(var.ip_configuration)) > 0 ? true : false

  is_postgres   = can(regex("^POSTGRES", var.database_version))
  iam_auth_flag = local.is_postgres ? "cloudsql.iam_authentication" : "cloudsql_iam_authentication"
  ip_configurations = {
    enabled  = var.ip_configuration
    disabled = {}
  }
  users = { for u in var.users : u.name => u }
  iam_users = {
    for user in var.iam_users : user.id => {
      email         = user.email,
      is_account_sa = trimsuffix(user.email, "gserviceaccount.com") == user.email ? false : true
    }
  }

  // HA method using REGIONAL availability_type requires binary logs to be enabled
  binary_log_enabled = var.availability_type == "REGIONAL" ? true : lookup(var.backup_configuration, "binary_log_enabled", null)
  backups_enabled    = var.availability_type == "REGIONAL" ? true : lookup(var.backup_configuration, "enabled", null)

  retained_backups = lookup(var.backup_configuration, "retained_backups", null)
  retention_unit   = lookup(var.backup_configuration, "retention_unit", null)

}

resource "random_id" "suffix" {
  byte_length = 4
}
