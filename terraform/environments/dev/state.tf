# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "cohere-tf-state-dev"
    prefix = "terraform/state"
  }
}