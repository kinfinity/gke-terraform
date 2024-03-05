resource "google_compute_router" "router" {
  name    = "router"
  region  = "us-central1"
  network = var.vpc_id
}