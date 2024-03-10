variable "cluster_id" {
  validation {
    condition     = var.cluster_id != ""
    error_message = "Cluster ID cannot be an empty string."
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


variable "name" {
  description = "Node pool name"
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "Node pool name cannot be empty!"
  }
}

variable "default_node_count" {
  default     = 1
   validation {
    condition     = var.default_node_count > 0
    error_message = "Default node count must be greater than 0."
  }
}

variable "max_nodes" {
  validation {
    condition     = var.max_nodes > 0
    error_message = "Max nodes must be greater than 0."
  }
}

variable "min_nodes" {
  validation {
    condition     = var.min_nodes > 0
    error_message = "Min nodes must be greater than 0."
  }
}
check "default_min_max_nodes_check" {
  assert {
    condition     = var.min_nodes > 0 && var.min_nodes < var.max_nodes
    error_message = "Min nodes must be greater than 0 and less than max nodes."
  }
  assert {
    condition     = var.default_node_count >= var.min_nodes && var.default_node_count <= var.max_nodes
    error_message = "Default node count must be between min nodes and max nodes."
  }
}

variable "node_locations" {
  default = ["us-central1-b"]
  # validation {
  #   condition     = can(all(regex("^[a-zA-Z][0-9]+-[a-z]$", var.node_locations)))
  #   error_message = "Invalid format for node locations. Each location should be in the format 'region-availability_zone' (e.g., 'us-central1-b')."
  # }
}
