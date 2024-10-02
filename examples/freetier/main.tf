module "freetier" {
  source     = "../.."
  project_id = var.project_id

  # Mandatory
  database_version  = "MYSQL_5_6"
  region            = "us-central1"
  name              = "db-freetier"
  availability_type = "ZONAL"

  # Optional
  tier      = "db-f1-micro"
  disk_size = "10"
}
