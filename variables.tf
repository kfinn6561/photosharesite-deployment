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
  type = string
  default="C:/Users/kiera/Dropbox/code/photo_site"
}