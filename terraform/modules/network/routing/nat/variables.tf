
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC id cannot be empty!"
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
      "us-east1",
      "us-east4",
      "us-west1",
      "us-west2",
      "us-west3",
      "us-west4",
      "us-central1",
      "northamerica-northeast1",
      "southamerica-east1",
      "europe-west1",
      "europe-west2",
      "europe-west3",
      "europe-west4",
      "europe-west6",
      "asia-east1",
      "asia-east2",
      "asia-northeast1",
      "asia-northeast2",
      "asia-northeast3",
      "asia-southeast1",
      "asia-southeast2",
      "australia-southeast1"
    ], var.region)
    error_message = "Use an approved region!"
  }
}

variable "subnet_id" {
  description = "subnet id"
  type        = string
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "Subnet id cannot be empty!"
  }
}

variable "router_name" {
  description = "router name"
  type        = string
  validation {
    condition     = length(var.router_name) > 0
    error_message = "Router name cannot be empty!"
  }
}

variable "nat_name" {
  description = " nat name."
  type        = string
  validation {
    condition     = length(var.nat_name) > 0
    error_message = "Nat name cannot be empty!"
  }
}
