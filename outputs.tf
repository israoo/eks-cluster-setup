output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS Kubernetes."
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_ca_data" {
  description = "The certificate-authority-data for the EKS Kubernetes."
  value = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}
