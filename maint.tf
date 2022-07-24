provider "google" {
  credentials = file("C:/Users/kiera/GCP_credentials/photosharesite-terraform.json")
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}


module "iam" {
  source = "./modules/iam"

  gcp_project = var.gcp_project
  backend_directory = format("%s/backend/PhotoBackend", var.root_directory)
}

module "storage" {
  source = "./modules/storage"

  gcp_project = var.gcp_project
  db_directory = format("%s/database", var.root_directory)
  backend_service_account_email = module.iam.backend_service_account_email
}