variable "gcp_project" {
  description = "gcp Project ID"
  type        = string
}

variable "gcp_region" {
  description = "region for the gcp resources"
  type        = string
}

variable "database_version" {
  description = "version of database to use"
  type        = string
  default     = "MYSQL_8_0"
}


variable "backend_service_account_email" {
  description = "email address of the backend service account"
  type        = string
}