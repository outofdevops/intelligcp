terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  region  = "europe-west1"
  zone    = "europe-west1-b"
}