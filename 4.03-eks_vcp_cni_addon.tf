resource "aws_eks_addon" "vpc_cni" { # Instala el add-on VPC CNI en el cluster de EKS
  cluster_name                = var.eks.cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = var.eks.addons.vpc_cni.version
  resolve_conflicts_on_create = local.eks_addons_resolve_conflicts_on_create
  resolve_conflicts_on_update = local.eks_addons_resolve_conflicts_on_update
  service_account_role_arn    = aws_iam_role.vpc_cni_role.arn # Asocia el rol de IAM del controlador de red de contenedores de EKS con el add-on (agrega un annotation al service account del controlador de red de contenedores)

  depends_on = [aws_eks_cluster.eks_cluster]

  timeouts {
    create = local.eks_addons_create_timeout
  }
}
