resource "google_storage_bucket" "storage-bucket" {
  name          = "photosharesite-store"
  location      = "EU"
  force_destroy = true

  uniform_bucket_level_access = true
}