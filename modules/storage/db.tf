resource "google_sql_database_instance" "pss-instance" {
  name             = "photosharesite-instance"
  region           = var.gcp_region
  database_version = var.database_version
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection = "false"
}

resource "google_sql_database" "pss-database" {
  name     = "photosharesite"
  instance = google_sql_database_instance.pss-instance.name
}

resource "google_sql_user" "backend-user" {
  name     = var.backend_service_account_email
  instance = google_sql_database_instance.pss-instance.name
  type     = "CLOUD_IAM_SERVICE_ACCOUNT"
}

resource "random_password" "admin-pwd" {
    length = 16
    special = false
}

resource "google_sql_user" "admin" {
    name = "admin"
    instance = google_sql_database_instance.pss-instance.name
    password = random_password.admin-pwd.result
}