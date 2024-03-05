provider "google" {
  project = var.project_id
  region  = var.main_region
  credentials = "${file(var.credentials_path)}"
}
