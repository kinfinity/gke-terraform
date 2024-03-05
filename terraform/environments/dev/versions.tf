terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.84.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

