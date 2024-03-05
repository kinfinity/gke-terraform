
output "vpc_id" {
 description = "vpc id"
 value       = google_compute_network.main.id
}

output "vpc_self_link" {
    value = google_compute_network.main.self_link
}