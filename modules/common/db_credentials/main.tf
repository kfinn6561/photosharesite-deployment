resource "random_password" "password" {
    length = 16
    special = false
}

resource "google_sql_user" "user" {
    name = var.username
    instance = var.database.name
    password = random_password.password.result
}

resource "google_sql_ssl_cert" "mysql_client_cert" {
  common_name = format("%s-%s",var.db_name, var.username)
  instance    = var.database.name
}

resource "local_file" "server_ca" {
  content  = google_sql_ssl_cert.mysql_client_cert.server_ca_cert
  filename = format("%s/secrets/server-ca.pem", var.local_directory)
}

resource "local_file" "client_cert" {
  content  = google_sql_ssl_cert.mysql_client_cert.cert
  filename = format("%s/secrets/client-cert.pem", var.local_directory)
}

resource "local_file" "client_key" {
  content  = google_sql_ssl_cert.mysql_client_cert.private_key
  filename = format("%s/secrets/client-key.pem", var.local_directory)
}

resource "local_file" "connection_string" {
  content = "server=${var.database.public_ip_address};uid=${google_sql_user.user.name};pwd=${google_sql_user.user.password};database=${var.db_name};Ssl-Cert=secrets/client-cert.pem;Ssl-Key=secrets/client-key.pem;Ssl-CA=secrets/server-ca.pem;Ssl-Mode=VerifyCA;AllowUserVariables=True"
  filename = format("%s/secrets/connection-string.txt", var.local_directory)
}