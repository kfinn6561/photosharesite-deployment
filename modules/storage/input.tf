variable "gcp_project" {
  description = "gcp Project ID"
  type        = string
}

variable "db_directory" {
  description = "directory of the db"
  type = string
}

variable "backend_service_account_email" {
  description = "email address of the backend service account"
  type = string
}