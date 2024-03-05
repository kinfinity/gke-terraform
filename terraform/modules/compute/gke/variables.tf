variable "cluster_name" {}

variable "region" {}

variable "default_node_count" {
  default = 1
}
variable "max_nodes" {}
variable "min_nodes" {}
variable "master_ipv4_cidr_block"{}

variable "node_locations" {
  default = ["us-central1-b"]
}

variable "network_selflink" {}

variable "subnetwork_selflink" {}

variable "logging_service" {
  default = "logging.googleapis.com/kubernetes"
}

variable "monitoring_service" {
  default = "monitoring.googleapis.com/kubernetes"
}

variable "workload_pool" {
  default = "circular-genius-416217.svc.id.goog"
}

variable "cluster_secondary_range_name" {
  default = "k8s-pod-range"
}

variable "services_secondary_range_name" {
  default = "k8s-service-range"
}