resource "google_container_cluster" "k8s_cluster" {
  name     = var.cluster_name
  location = var.region

  # Enable Autopilot mode
  enable_autopilot = true

  # Attach the cluster to your Week 2 VPC network
  network = var.network_name

  # Restrict cluster management to the selected release channel
  release_channel {
    channel = "REGULAR"
  }

  # Standard cloud security best practice
}

output "cluster_endpoint" {
  value       = google_container_cluster.k8s_cluster.endpoint
  description = "The IP address of the cluster master"
}

output "cluster_ca_certificate" {
  value       = google_container_cluster.k8s_cluster.master_auth[0].cluster_ca_certificate
  description = "The public certificate authority of the cluster control plane"
}