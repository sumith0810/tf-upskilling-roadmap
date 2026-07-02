# Create the argocd namespace automatically
resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

# Deploy ArgoCD via its official Helm chart
resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.46.7" # Uses a stable chart version
  namespace  = kubernetes_namespace.argocd.metadata[0].name

  # Ensure Helm waits for all pods to be ready before finishing
  wait = false 
}