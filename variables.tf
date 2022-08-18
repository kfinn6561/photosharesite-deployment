variable "gcp_credential_path" {
  description = "absolute path of the gcp credentials file"
  type = string
  default = "C:/Users/kiera/GCP_credentials/photosharesite-terraform.json"
}


variable "gcp_project" {
  description = "gcp Project ID"
  type        = string
  default     = "photosharesite"
}

variable "gcp_region" {
  description = "default gcp region"
  type        = string
  default     = "europe-west2"
}

variable "gcp_zone" {
  description = "default gcp zone"
  type        = string
  default     = "europe-west2-a"
}

variable "root_directory" {
  description = "root directory"
  type        = string
  default     = "C:/Users/kiera/Dropbox/code/photo_site"
}

variable "backend_dir_name" {
  description = "name of the backend directory"
  type = string
  default = "backend"
}

variable "db_dir_name" {
  description = "name of the database directory"
  type = string
  default = "database"
}