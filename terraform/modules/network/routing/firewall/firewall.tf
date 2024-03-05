resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = var.vpc_id

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}