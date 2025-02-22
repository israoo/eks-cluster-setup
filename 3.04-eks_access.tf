resource "aws_eks_access_entry" "admin_access_entry" { # Crea una entrada de acceso a EKS
  cluster_name  = var.eks.cluster_name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.aws_user}" # Asocia la entrada de acceso a EKS con el usuario de AWS
  type          = "STANDARD"                                                                         # Define el tipo de entrada de acceso a EKS (STANDARD porque es un usuario de AWS)

  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "aws_eks_access_policy_association" "admin_access_policy_association" { # Asocia una política de acceso a EKS
  cluster_name  = var.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"               # Asocia la política de acceso a EKS con el rol de administrador
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${var.aws_user}" # Asocia la política de acceso con la entrada de acceso a EKS

  access_scope {
    type = "cluster" # Define el alcance de acceso a EKS
  }

  depends_on = [aws_eks_access_entry.admin_access_entry]
}
