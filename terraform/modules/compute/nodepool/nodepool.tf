resource "google_service_account" "kubernetes" {
  account_id   = "${var.name}-k8s-sa"
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
    name       = "${var.name}-node-pool"
    location   = var.region
    cluster    = var.cluster_id
    node_count = var.default_node_count

    autoscaling {
      min_node_count = var.min_nodes
      max_node_count = var.max_nodes
    }
    node_locations = var.node_locations

    node_config {
        preemptible  = true
        machine_type = "e2-medium"
        disk_size_gb = 50

        # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
        service_account = google_service_account.kubernetes.email
        oauth_scopes    = [
        "https://www.googleapis.com/auth/cloud-platform"
        ]
    }
}