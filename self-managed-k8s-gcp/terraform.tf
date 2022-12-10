terraform {
  required_version = ">=0.13"
  required_providers {
    google = {
        source = "hashicorp/google"
        version = "4.45.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region = var.region
  zone = var.zone
  credentials = var.credentials
}
