resource "google_compute_subnetwork" "private" {
  name                     = var.subnetwork_name
  ip_cidr_range            = var.ip_cidr_range
  region                   = var.region
  network                  = var.vpc_id
  private_ip_google_access = true

  dynamic "secondary_ip_range" {
    for_each = var.k8s_pod_ranges
    content {
      range_name    = "k8s-pod-range"
      ip_cidr_range = secondary_ip_range.value
    }
  }

  dynamic "secondary_ip_range" {
    for_each = var.k8s_service_ranges
    content {
      range_name    = "k8s-service-range"
      ip_cidr_range = secondary_ip_range.value
    }
  }
}
