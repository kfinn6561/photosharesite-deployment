
resource "google_bigquery_dataset" "dataset" {
  dataset_id    = "photosharesite_data"
  friendly_name = "photo share site data"
  description   = "data for the photo share site"

  access {
    role          = "OWNER"
    user_by_email = var.backend_service_account_email
  }

  access {
    role          = "OWNER"
    user_by_email = format("terraform@%s.iam.gserviceaccount.com", var.gcp_project)
  }

  access {
    role          = "OWNER"
    user_by_email = "kieran.finn04@gmail.com"
  }
}

resource "google_bigquery_table" "MediaFiles" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "MediaFiles"

  schema              = file(format("%s/MediaFiles_Schema.json",var.db_directory))
  deletion_protection = false

}

resource "google_bigquery_table" "Users" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "Users"

  schema = file(format("%s/Users_Schema.json",var.db_directory))

  deletion_protection = false

}

resource "google_bigquery_routine" "select_files_routine" {
  dataset_id      = google_bigquery_dataset.dataset.dataset_id
  routine_id      = "select_files"
  routine_type    = "PROCEDURE"
  language        = "SQL"
  definition_body = file(format("%s/SelectFiles.prc",var.db_directory))
}