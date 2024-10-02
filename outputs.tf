output "instance_name" {
  value       = google_sql_database_instance.main.name
  description = "The instance name for the master instance"
}

output "instance_ip_address" {
  value       = google_sql_database_instance.main.ip_address
  description = "The IPv4 address assigned for the master instance"
}

output "private_address" {
  value       = google_sql_database_instance.main.private_ip_address
  description = "The private IP address assigned for the master instance"
}

output "instance_first_ip_address" {
  value       = google_sql_database_instance.main.first_ip_address
  description = "The first IPv4 address of the addresses assigned for the master instance."
}

output "instance_connection_name" {
  value       = google_sql_database_instance.main.connection_name
  description = "The connection name of the master instance to be used in connection strings"
}

output "instance_self_link" {
  value       = google_sql_database_instance.main.self_link
  description = "The URI of the master instance"
}

output "instance_server_ca_cert" {
  value       = google_sql_database_instance.main.server_ca_cert
  description = "The CA certificate information used to connect to the SQL instance via SSL"
  sensitive   = true
}

output "instance_service_account_email_address" {
  value       = google_sql_database_instance.main.service_account_email_address
  description = "The service account email address assigned to the master instance"
}

output "public_ip_address" {
  description = "The first public (PRIMARY) IPv4 address assigned for the master instance"
  value       = google_sql_database_instance.main.public_ip_address
}

output "private_ip_address" {
  description = "The first private (PRIVATE) IPv4 address assigned for the master instance"
  value       = google_sql_database_instance.main.private_ip_address
}

// Resources
output "primary" {
  value       = google_sql_database_instance.main
  description = "The `google_sql_database_instance` resource representing the primary instance"
  sensitive   = true
}

// Users

output "user_names" {
  description = "List of user names"
  value       = keys(local.users)
}

output "user_passwords" {
  description = "Map of user names and their corresponding details"
  value = {
    for name, user in local.users : name => {
      name     = user.name
      password = user.random_password ? random_password.random_passwords[name].result : user.password
    }
  }
  sensitive = true
}

output "root_password" {
  description = "Password for the root user"
  value       = random_password.random_root_password.result
  sensitive   = true
}
