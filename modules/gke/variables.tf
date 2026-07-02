variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "region" {
  type        = string
  description = "GCP region to deploy the cluster"
}

variable "network_name" {
  type        = string
  description = "The name of the VPC network to attach to"
}