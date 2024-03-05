output "name" {
  value = google_container_cluster.primary.name
}

output "id" {
  value = google_container_cluster.primary.id
}

output "location" {
  value = google_container_cluster.primary.location
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}
