terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "dev_vpc" {
  source   = "../../modules/vpc"
  vpc_name = "dev-platform-vpc"
  region   = var.region
}