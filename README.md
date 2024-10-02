<!-- BEGIN_TF_DOCS -->
## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The database version to use | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the Cloud SQL resources | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to manage the Cloud SQL resources | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region of the Cloud SQL resources | `string` | n/a | yes |
| <a name="input_activation_policy"></a> [activation\_policy](#input\_activation\_policy) | The activation policy for the master instance. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`. | `string` | `"ALWAYS"` | no |
| <a name="input_availability_type"></a> [availability\_type](#input\_availability\_type) | The availability type for the master instance. Can be either `REGIONAL` or `null`. | `string` | `"REGIONAL"` | no |
| <a name="input_backup_configuration"></a> [backup\_configuration](#input\_backup\_configuration) | The backup\_configuration settings subblock for the database setings | <pre>object({<br>    binary_log_enabled             = optional(bool, false)<br>    enabled                        = optional(bool, false)<br>    start_time                     = optional(string)<br>    location                       = optional(string)<br>    transaction_log_retention_days = optional(string)<br>    retained_backups               = optional(number)<br>    retention_unit                 = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_create_timeout"></a> [create\_timeout](#input\_create\_timeout) | The optional timout that is applied to limit long database creates. | `string` | `"30m"` | no |
| <a name="input_data_cache_enabled"></a> [data\_cache\_enabled](#input\_data\_cache\_enabled) | Whether data cache is enabled for the instance. Defaults to false. Feature is only available for ENTERPRISE\_PLUS tier and supported database\_versions | `bool` | `false` | no |
| <a name="input_database_flags"></a> [database\_flags](#input\_database\_flags) | List of Cloud SQL flags that are applied to the database server. See [more details](https://cloud.google.com/sql/docs/mysql/flags) | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | A list of databases to be created in your cloudsql | `list(string)` | `[]` | no |
| <a name="input_delete_timeout"></a> [delete\_timeout](#input\_delete\_timeout) | The optional timout that is applied to limit long database deletes. | `string` | `"30m"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Used to block Terraform from deleting a SQL Instance. | `bool` | `true` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Enables protection of an instance from accidental deletion across all surfaces (API, gcloud, Cloud Console and Terraform). | `bool` | `false` | no |
| <a name="input_disk_autoresize"></a> [disk\_autoresize](#input\_disk\_autoresize) | Configuration to increase storage size | `bool` | `true` | no |
| <a name="input_disk_autoresize_limit"></a> [disk\_autoresize\_limit](#input\_disk\_autoresize\_limit) | The maximum size to which storage can be auto increased. | `number` | `0` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | The disk size for the master instance | `number` | `10` | no |
| <a name="input_disk_type"></a> [disk\_type](#input\_disk\_type) | The disk type for the master instance. | `string` | `"PD_SSD"` | no |
| <a name="input_edition"></a> [edition](#input\_edition) | The edition of the instance, can be ENTERPRISE or ENTERPRISE\_PLUS. | `string` | `null` | no |
| <a name="input_iam_groups"></a> [iam\_groups](#input\_iam\_groups) | A list of IAM groups to give access to your CloudSQL instance | `list(string)` | `[]` | no |
| <a name="input_iam_users"></a> [iam\_users](#input\_iam\_users) | A list of IAM users to be created in your CloudSQL instance | <pre>list(object({<br>    id    = string,<br>    email = string<br>  }))</pre> | `[]` | no |
| <a name="input_insights_config"></a> [insights\_config](#input\_insights\_config) | The insights\_config settings for the database. | <pre>object({<br>    query_plans_per_minute  = number<br>    query_string_length     = number<br>    record_application_tags = bool<br>    record_client_address   = bool<br>  })</pre> | `null` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | The ip\_configuration settings subblock | <pre>object({<br>    authorized_networks                           = optional(list(map(string)), [])<br>    ipv4_enabled                                  = optional(bool, true)<br>    private_network                               = optional(string)<br>    allocated_ip_range                            = optional(string)<br>    enable_private_path_for_google_cloud_services = optional(bool, false)<br>  })</pre> | `{}` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | The day of week (1-7) for the master instance maintenance. | `number` | `1` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | The hour of day (0-23) maintenance window for the master instance maintenance. | `number` | `23` | no |
| <a name="input_maintenance_window_update_track"></a> [maintenance\_window\_update\_track](#input\_maintenance\_window\_update\_track) | The update track of maintenance window for the master instance maintenance. Can be either `canary` or `stable`. | `string` | `"canary"` | no |
| <a name="input_pricing_plan"></a> [pricing\_plan](#input\_pricing\_plan) | The pricing plan for the master instance. | `string` | `"PER_USE"` | no |
| <a name="input_root_password"></a> [root\_password](#input\_root\_password) | MySQL password for the root user. | `string` | `null` | no |
| <a name="input_tier"></a> [tier](#input\_tier) | The tier for the master instance. | `string` | `"db-n1-standard-1"` | no |
| <a name="input_update_timeout"></a> [update\_timeout](#input\_update\_timeout) | The optional timout that is applied to limit long database updates. | `string` | `"30m"` | no |
| <a name="input_user_labels"></a> [user\_labels](#input\_user\_labels) | The key/value labels for the master instances. | `map(string)` | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | A list of users to be created in your cluster. A random password would be set for the user if the `random_password` variable is set. | <pre>list(object({<br>    name            = string<br>    password        = optional(string)<br>    random_password = optional(bool)<br>  }))</pre> | `[]` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone for the master instance, it should be something like: `us-central1-a`, `us-east1-c`. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_connection_name"></a> [instance\_connection\_name](#output\_instance\_connection\_name) | The connection name of the master instance to be used in connection strings |
| <a name="output_instance_first_ip_address"></a> [instance\_first\_ip\_address](#output\_instance\_first\_ip\_address) | The first IPv4 address of the addresses assigned for the master instance. |
| <a name="output_instance_ip_address"></a> [instance\_ip\_address](#output\_instance\_ip\_address) | The IPv4 address assigned for the master instance |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The instance name for the master instance |
| <a name="output_instance_self_link"></a> [instance\_self\_link](#output\_instance\_self\_link) | The URI of the master instance |
| <a name="output_instance_server_ca_cert"></a> [instance\_server\_ca\_cert](#output\_instance\_server\_ca\_cert) | The CA certificate information used to connect to the SQL instance via SSL |
| <a name="output_instance_service_account_email_address"></a> [instance\_service\_account\_email\_address](#output\_instance\_service\_account\_email\_address) | The service account email address assigned to the master instance |
| <a name="output_primary"></a> [primary](#output\_primary) | The `google_sql_database_instance` resource representing the primary instance |
| <a name="output_private_address"></a> [private\_address](#output\_private\_address) | The private IP address assigned for the master instance |
| <a name="output_private_ip_address"></a> [private\_ip\_address](#output\_private\_ip\_address) | The first private (PRIVATE) IPv4 address assigned for the master instance |
| <a name="output_public_ip_address"></a> [public\_ip\_address](#output\_public\_ip\_address) | The first public (PRIMARY) IPv4 address assigned for the master instance |
| <a name="output_root_password"></a> [root\_password](#output\_root\_password) | Password for the root user |
| <a name="output_user_names"></a> [user\_names](#output\_user\_names) | List of user names |
| <a name="output_user_passwords"></a> [user\_passwords](#output\_user\_passwords) | Map of user names and their corresponding details |
<!-- END_TF_DOCS -->