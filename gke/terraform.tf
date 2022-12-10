terraform {
  required_version = ">=0.12"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.52.0"
    }
  }

  backend "gcs" {
    bucket = "tugas-akhir-1729-bucket"
    prefix = "terraform/state"
  }
}

provider "google" {
  project = var.project_id
  region = var.region
}