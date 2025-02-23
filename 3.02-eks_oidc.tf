resource "aws_iam_openid_connect_provider" "eks_oidc" { # Crea un proveedor de identidad OpenID Connect (OIDC) para el clúster de EKS (necesario para habilitar el uso de roles de IAM en los pods de Kubernetes - IRSA)
  client_id_list  = [local.eks_oidc_client_id]                                  # Lista de clientes ID permitidos para el proveedor OIDC (en este caso, solo el cliente ID del clúster de EKS)
  thumbprint_list = [data.tls_certificate.this.certificates.0.sha1_fingerprint] # Lista de huellas digitales de certificados permitidos para el proveedor OIDC (en este caso, la huella digital del certificado del clúster de EKS)
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer      # URL del proveedor OIDC del clúster de EKS

  tags = {
    Cluster = var.eks.cluster_name
  }
}
