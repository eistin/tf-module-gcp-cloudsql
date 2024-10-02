module "ha" {
  source     = "../.."
  project_id = var.project_id

  database_version = "MYSQL_8_0"
  region           = "europe-west1"
  name             = "db-ha"

  availability_type = "REGIONAL"
  tier              = "db-n1-standard-1"
  disk_size         = "30"

  database_flags = [
    {
      name  = "cloudsql_iam_authentication"
      value = "on"
    },
  ]
}
