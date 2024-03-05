
output "subnet_id" {
 description = "subnet id"
 value       = google_compute_subnetwork.private.id
}
output "subnet_self_link" {
  value = google_compute_subnetwork.private.self_link
}