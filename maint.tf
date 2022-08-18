provider "google" {
  credentials = file(var.gcp_credential_path)
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}


module "iam" {
  source = "./modules/iam"

  gcp_project       = var.gcp_project
  backend_directory = format("%s/%s/PhotoBackend", var.root_directory, var.backend_dir_name)
}

module "storage" {
  source = "./modules/storage"

  gcp_project                   = var.gcp_project
  gcp_region                    = var.gcp_region
  backend_service_account_email = module.iam.backend_service_account_email
  backend_directory = format("%s/%s/PhotoBackend", var.root_directory, var.backend_dir_name)
  db_directory = format("%s/%s", var.root_directory, var.db_dir_name)
}

output "DB-admin-password" {
  value     = module.storage.admin-password
  sensitive = true
}