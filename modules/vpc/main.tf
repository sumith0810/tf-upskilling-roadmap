resource "google_compute_network" "vpc" {
  name                    = var.vpc_name
  auto_create_subnetworks = true # Automatically creates a subnet in each region
}