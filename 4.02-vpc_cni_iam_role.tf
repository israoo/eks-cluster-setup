resource "aws_iam_role" "vpc_cni_role" { # Crea un rol de IAM para el controlador de red de contenedores de EKS (pods aws-node)
  name = local.aws_node.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.eks_cluster_oidc_issuer}" # Permite a los pods asumir el rol de IAM con Web Identity Federation (usando el proveedor OIDC del clúster de EKS)
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${local.eks_cluster_oidc_issuer}:aud" = local.eks_oidc_client_id                                                                        # Valida que el audience del token OIDC sea el cliente ID del proveedor OIDC
          "${local.eks_cluster_oidc_issuer}:sub" = "system:serviceaccount:${local.aws_node.namespace_name}:${local.aws_node.service_account_name}" # Valida que el subject del token OIDC sea el service account del pod
        }
      }
    }]
  })

  tags = {
    Name = local.aws_node.role_name
  }
}

resource "aws_iam_role_policy_attachment" "vpc_cni_policy_attachment" { # Adjunta una política de IAM al rol del controlador de red de contenedores de EKS
  role       = aws_iam_role.vpc_cni_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" # Necesario para configurar la red de contenedores de EKS (por ejemplo, crear interfaces de red, asignar direcciones IP, etc.)

  depends_on = [aws_iam_role.vpc_cni_role]
}
