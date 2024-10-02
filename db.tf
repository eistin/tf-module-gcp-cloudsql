resource "google_sql_database_instance" "main" {
  provider            = google-beta
  project             = var.project_id
  name                = local.master_instance_name
  database_version    = var.database_version
  region              = var.region
  deletion_protection = var.deletion_protection
  root_password       = var.root_password == "" ? null : var.root_password

  settings {
    tier                        = var.tier
    edition                     = var.edition
    activation_policy           = var.activation_policy
    availability_type           = var.availability_type
    deletion_protection_enabled = var.deletion_protection_enabled

    dynamic "database_flags" {
      for_each = var.database_flags
      content {
        name  = lookup(database_flags.value, "name", null)
        value = lookup(database_flags.value, "value", null)
      }
    }

    dynamic "backup_configuration" {
      for_each = [var.backup_configuration]
      content {
        binary_log_enabled             = local.binary_log_enabled
        enabled                        = local.backups_enabled ? true : false
        start_time                     = lookup(backup_configuration.value, "start_time", null)
        location                       = lookup(backup_configuration.value, "location", null)
        transaction_log_retention_days = lookup(backup_configuration.value, "transaction_log_retention_days", null)

        dynamic "backup_retention_settings" {
          for_each = local.retained_backups != null || local.retention_unit != null ? [var.backup_configuration] : []
          content {
            retained_backups = local.retained_backups
            retention_unit   = local.retention_unit
          }
        }
      }
    }
    dynamic "insights_config" {
      for_each = var.insights_config != null ? [var.insights_config] : []

      content {
        query_insights_enabled  = true
        query_plans_per_minute  = lookup(insights_config.value, "query_plans_per_minute", 5)
        query_string_length     = lookup(insights_config.value, "query_string_length", 1024)
        record_application_tags = lookup(insights_config.value, "record_application_tags", false)
        record_client_address   = lookup(insights_config.value, "record_client_address", false)
      }
    }
    dynamic "data_cache_config" {
      for_each = var.edition == "ENTERPRISE_PLUS" && var.data_cache_enabled ? ["cache_enabled"] : []
      content {
        data_cache_enabled = var.data_cache_enabled
      }
    }

    dynamic "ip_configuration" {
      for_each = [local.ip_configurations[local.ip_configuration_enabled ? "enabled" : "disabled"]]
      content {
        ipv4_enabled                                  = lookup(ip_configuration.value, "ipv4_enabled", null)
        private_network                               = lookup(ip_configuration.value, "private_network", null)
        allocated_ip_range                            = lookup(ip_configuration.value, "allocated_ip_range", null)
        enable_private_path_for_google_cloud_services = lookup(ip_configuration.value, "enable_private_path_for_google_cloud_services", false)

        dynamic "authorized_networks" {
          for_each = lookup(ip_configuration.value, "authorized_networks", [])
          content {
            expiration_time = lookup(authorized_networks.value, "expiration_time", null)
            name            = lookup(authorized_networks.value, "name", null)
            value           = lookup(authorized_networks.value, "value", null)
          }
        }
      }
    }

    disk_autoresize       = var.disk_autoresize
    disk_autoresize_limit = var.disk_autoresize_limit

    disk_size    = var.disk_size
    disk_type    = var.disk_type
    pricing_plan = var.pricing_plan
    user_labels  = var.user_labels

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.maintenance_window_update_track
    }
  }

  lifecycle {
    ignore_changes = [
      settings[0].disk_size
    ]
  }

  timeouts {
    create = var.create_timeout
    update = var.update_timeout
    delete = var.delete_timeout
  }
}



# Databases
resource "google_sql_database" "databases" {
  for_each = toset(var.databases)
  project  = var.project_id
  name     = each.key
  instance = google_sql_database_instance.main.name
}

# Users
# Root User
resource "google_sql_user" "root" {
  name     = "root"
  instance = google_sql_database_instance.main.name
  password = random_password.random_root_password.result
}

resource "random_password" "random_root_password" {
  length     = 16
  special    = false
  depends_on = [google_sql_database_instance.main]
}

# IAM Users
resource "google_sql_user" "iam_accounts" {
  for_each = local.iam_users

  project  = var.project_id
  name     = each.value.email
  instance = google_sql_database_instance.main.name
  type     = each.value.is_account_sa ? "CLOUD_IAM_SERVICE_ACCOUNT" : "CLOUD_IAM_USER"
}

# IAM Groups
resource "google_sql_user" "iam_groups" {
  for_each = toset(var.iam_groups)

  project  = var.project_id
  name     = each.key
  instance = google_sql_database_instance.main.name
  type     = "CLOUD_IAM_GROUP"
}

# Postgres Built-in Users
resource "google_sql_user" "users" {
  for_each = local.users
  project  = var.project_id
  name     = each.value.name
  password = each.value.random_password ? random_password.random_passwords[each.value.name].result : each.value.password
  instance = google_sql_database_instance.main.name
  depends_on = [
    google_sql_database_instance.main
  ]
}

# Random Passwords
resource "random_password" "random_passwords" {
  for_each   = local.users
  length     = 16
  special    = false
  depends_on = [google_sql_database_instance.main]
}

