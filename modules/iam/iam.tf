resource "google_service_account" "backend_service_account" {
  account_id = "backend-service-account"
}

resource "google_project_iam_member" "storage_permission" {
  project = var.gcp_project
  role    = "roles/storage.objectAdmin"
  member  = format("serviceAccount:%s", google_service_account.backend_service_account.email)
}

resource "google_service_account_key" "backend_key" {
  service_account_id = google_service_account.backend_service_account.name
}

resource "local_file" "private_key" {
  content  = google_service_account_key.backend_key.private_key
  filename = format("%s/backend-key.json", var.backend_directory)
}