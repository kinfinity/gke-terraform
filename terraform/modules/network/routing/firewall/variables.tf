
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
   validation {
    condition     = length(var.vpc_id) > 0
    error_message = "VPC id cannot be empty!"
  }
}
