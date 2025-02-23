resource "aws_eks_addon" "ebs_csi_driver" { # Instala el add-on EBS CSI Driver en el cluster de EKS
  cluster_name                = var.eks.cluster_name
  addon_name                  = "aws-ebs-csi-driver"
  addon_version               = var.eks.addons.aws_ebs_csi_driver.version
  resolve_conflicts_on_create = local.eks_addons_resolve_conflicts_on_create
  resolve_conflicts_on_update = local.eks_addons_resolve_conflicts_on_update
  service_account_role_arn    = aws_iam_role.ebs_csi_driver_role.arn # Asocia el rol de IAM del controlador CSI de EBS con el add-on (agrega un annotation al service account del controlador CSI de EBS)

  configuration_values = jsonencode({ # Configura el add-on EBS CSI Driver
    controller: {
      sdkDebugLog = false # Habilita o deshabilita el registro de depuración del controlador (útil para depurar problemas con el controlador)
    }
    sidecars: {
      snapshotter: {
        forceEnable: false # Habilita o deshabilita el snapshotter sidecar (útil para habilitar la creación de snapshots de volúmenes EBS)
      }
    }
  })

  depends_on = [aws_eks_cluster.eks_cluster]
}
