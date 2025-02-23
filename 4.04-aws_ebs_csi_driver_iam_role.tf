resource "aws_iam_role" "ebs_csi_driver_role" { # Crea un rol de IAM para el controlador CSI de EBS
  name = local.ebs_csi_driver.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.eks_cluster_oidc_issuer}"
      }
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${local.eks_cluster_oidc_issuer}:aud" = "sts.amazonaws.com"
          "${local.eks_cluster_oidc_issuer}:sub" = "system:serviceaccount:${local.ebs_csi_driver.namespace_name}:${local.ebs_csi_driver.service_account_name}"
        }
      }
    }]
  })

  tags = {
    Name = local.ebs_csi_driver.role_name
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy_attachment" { # Adjunta una política de IAM al rol del controlador CSI de EBS
  role       = aws_iam_role.ebs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy" # Necesario para que el controlador CSI de EBS pueda interactuar con los recursos de EBS (por ejemplo, crear volúmenes, adjuntar volúmenes, etc.)

  depends_on = [aws_iam_role.ebs_csi_driver_role]
}
