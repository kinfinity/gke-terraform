variable "cluster_id" {}

variable "region" {}
variable "name" {}

variable "default_node_count" {
  default = 1
}
variable "max_nodes" {}
variable "min_nodes" {}
variable "node_locations" {}