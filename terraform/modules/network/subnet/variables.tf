variable "subnetwork_name" {
  description = "Name of the subnetwork"
  type        = string
  default     = "private"
  validation {
    condition     = length(var.subnetwork_name) > 0
    error_message = "Subnet name cannot be empty!"
  }
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC ID cannot be empty!"
  }
}

variable "ip_cidr_range" {
  description = "IP CIDR range for the subnetwork"
  type        = string
  default     = "10.0.0.0/18"
  validation {
    condition     = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}$", var.ip_cidr_range))
    error_message = "Invalid CIDR notation for IP CIDR range."
  }
}

variable "region" {
  description = "Region for the subnetwork"
  type        = string
  validation {
    condition     = length(var.region) > 0
    error_message = "Region cannot be empty!"
  }
  validation {
    condition     = contains([
      "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4", "us-central1",
      "northamerica-northeast1", "southamerica-east1", "europe-west1", "europe-west2", "europe-west3",
      "europe-west4", "europe-west6", "asia-east1", "asia-east2", "asia-northeast1", "asia-northeast2",
      "asia-northeast3", "asia-southeast1", "asia-southeast2", "australia-southeast1"
    ], var.region)
    error_message = "Use an approved region!"
  }
}

variable "k8s_pod_ranges" {
  description = "List of Kubernetes pod IP ranges"
  type        = list(string)
  default     = ["10.48.0.0/14"]
  # validation {
  #   condition     = can(all(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}(?:,(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2})*$", var.k8s_pod_ranges)))
  #   error_message = "Invalid CIDR notation for one or more Kubernetes pod IP ranges."
  # }
}

variable "k8s_service_ranges" {
  description = "List of Kubernetes service IP ranges"
  type        = list(string)
  default     = ["10.52.0.0/20"]
  # validation {
  #   condition     = can(all(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2}(?:,(?:[0-9]{1,3}\\.){3}[0-9]{1,3}/[0-9]{1,2})*$", var.k8s_service_ranges)))
  #   error_message = "Invalid CIDR notation for one or more Kubernetes service IP ranges."
  # }
}
