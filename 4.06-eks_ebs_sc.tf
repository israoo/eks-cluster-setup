resource "kubernetes_storage_class" "eks_ebs_sc" { # Crea una clase de almacenamiento para volúmenes EBS
  metadata {
    name = var.eks.ebs_storage_class.name
    annotations = {
      "storageclass.kubernetes.io/is-default-class" = "true" # Marca la clase de almacenamiento como la clase de almacenamiento predeterminada
    }
  }

  allow_volume_expansion = var.eks.ebs_storage_class.allow_volume_expansion # Habilita o deshabilita la expansión de volúmenes

  parameters = {
    type = var.eks.ebs_storage_class.type # Tipo de volumen EBS (por ejemplo, gp2, gp3, io1, etc.)
  }

  reclaim_policy      = var.eks.ebs_storage_class.reclaim_policy      # Política de reclamación de volúmenes (por ejemplo, Retain, Delete, etc.)
  storage_provisioner = "ebs.csi.aws.com"                             # Proveedor de almacenamiento para volúmenes EBS
  volume_binding_mode = var.eks.ebs_storage_class.volume_binding_mode # Modo de enlace de volúmenes (por ejemplo, WaitForFirstConsumer, Immediate, etc.)

  depends_on = [aws_eks_access_policy_association.admin_access_policy_association]
}
