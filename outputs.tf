output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS Kubernetes."
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_name" {
  description = "The name of the EKS Kubernetes."
  value = aws_eks_cluster.eks_cluster.name
}
