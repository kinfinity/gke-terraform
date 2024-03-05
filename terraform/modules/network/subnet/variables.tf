variable "subnetwork_name" {
  description = "Name of the subnetwork"
  type        = string
  default     = "private"
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "ip_cidr_range" {
  description = "IP CIDR range for the subnetwork"
  type        = string
  default     = "10.0.0.0/18"
}

variable "region" {
  description = "Region for the subnetwork"
  type        = string
}

variable "k8s_pod_ranges" {
  description = "List of Kubernetes pod IP ranges"
  type        = list(string)
  default     = ["10.48.0.0/14"]
}

variable "k8s_service_ranges" {
  description = "List of Kubernetes service IP ranges"
  type        = list(string)
  default     = ["10.52.0.0/20"]
}
