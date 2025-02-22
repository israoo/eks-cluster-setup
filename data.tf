data "aws_caller_identity" "current" {} # Obtiene la identidad del usuario actual de AWS

data "aws_eks_cluster_auth" "this" { # Obtiene la información de autenticación del clúster de EKS
  name = var.eks.cluster_name
}

data "tls_certificate" "this" { # Obtiene el certificado del clúster de EKS
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
