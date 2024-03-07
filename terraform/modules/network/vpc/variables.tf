variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "Cohere Infrastructure"
  validation {
    condition     = length(var.vpc_name) > 0
    error_message = "VPC Name cannot be empty!"
  }
}
