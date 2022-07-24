resource "google_sql_database_instance" "pss-instance" {
  name             = "photosharesite-test-24072"
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

resource "google_sql_ssl_cert" "mysql_client_cert" {
  common_name = "photosharesite"
  instance    = google_sql_database_instance.pss-instance.name
}

resource "local_file" "server_ca" {
  content  = google_sql_ssl_cert.mysql_client_cert.server_ca_cert
  filename = format("%s/secrets/server-ca.pem", var.backend_directory)
}

resource "local_file" "client_cert" {
  content  = google_sql_ssl_cert.mysql_client_cert.cert
  filename = format("%s/secrets/client-cert.pem", var.backend_directory)
}

resource "local_file" "client_key" {
  content  = google_sql_ssl_cert.mysql_client_cert.private_key
  filename = format("%s/secrets/client-key.pem", var.backend_directory)
}