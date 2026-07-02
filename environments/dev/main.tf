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

module "dev_gke" {
  source       = "../../modules/gke"
  cluster_name = "dev-platform-cluster"
  region       = var.region
  
  # Dependency Injection: Passing the output of the VPC module straight into GKE
  network_name = module.dev_vpc.network_name
}