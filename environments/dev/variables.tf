variable "project_id" {
  type        = string
  description = "Your GCP Project ID"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Default GCP region"
}