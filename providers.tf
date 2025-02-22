provider "aws" {
  default_tags {
    tags = {
      Environment = var.tags.environment
      Service     = var.tags.service
    }
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)

  token = data.aws_eks_cluster_auth.this.token
}
