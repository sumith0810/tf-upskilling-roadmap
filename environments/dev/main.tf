terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.17"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Dynamically fetch auth tokens from GKE to feed into Kubernetes/Helm providers
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.dev_gke.cluster_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.dev_gke.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.dev_gke.cluster_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.dev_gke.cluster_ca_certificate)
  }
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
  network_name = module.dev_vpc.network_name
}