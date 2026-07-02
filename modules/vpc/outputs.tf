output "network_name" {
  value       = google_compute_network.vpc.name
  description = "The name of the created VPC"
}