variable "gke_name" {
  type        = string
  description = "Name of the GKE cluster"
  validation {
    condition     = length(var.gke_name) > 0
    error_message = "gke_name must not be an empty string"
  }
}

variable "main_region" {
  description = "Region for the subnetwork"
  type        = string
  validation {
    condition     = length(var.main_region) > 0
    error_message = "Region cannot be empty!"
  }

  validation {
    condition = contains([
      "us-east1", "us-east4", "us-west1", "us-west2", "us-west3", "us-west4", "us-central1",
      "northamerica-northeast1", "southamerica-east1", "europe-west1", "europe-west2", "europe-west3",
      "europe-west4", "europe-west6", "asia-east1", "asia-east2", "asia-northeast1", "asia-northeast2",
      "asia-northeast3", "asia-southeast1", "asia-southeast2", "australia-southeast1"
    ], var.main_region)
    error_message = "Use an approved region!"
  }
}


variable "gke_node_count" {
  type        = number
  description = "Number of nodes in the GKE cluster"
  validation {
    condition     = var.gke_node_count > 0
    error_message = "gke_node_count must be greater than 0"
  }
}

variable "project_id" {
  type        = string
  description = "Google Cloud project ID"
  validation {
    condition     = length(var.project_id) > 0
    error_message = "project_id must not be an empty string"
  }
}

variable "env_name" {
  type        = string
  description = "Environment name"
  validation {
    condition     = length(var.env_name) > 0
    error_message = "env_name must not be an empty string"
  }
}

variable "network" {
  type        = string
  description = "Name of the network"
  validation {
    condition     = length(var.network) > 0
    error_message = "network must not be an empty string"
  }
}

variable "subnetwork" {
  type        = string
  description = "Name of the subnetwork"
  validation {
    condition     = length(var.subnetwork) > 0
    error_message = "subnetwork must not be an empty string"
  }
}
