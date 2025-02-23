resource "aws_eks_addon" "coredns" { # Instala el add-on CoreDNS en el cluster de EKS
  cluster_name                = var.eks.cluster_name
  addon_name                  = "coredns"
  addon_version               = var.eks.addons.coredns.version
  resolve_conflicts_on_create = local.eks_addons_resolve_conflicts_on_create # Resuelve conflictos al crear el add-on (por ejemplo, si ya existe un add-on con el mismo nombre)
  resolve_conflicts_on_update = local.eks_addons_resolve_conflicts_on_update # Resuelve conflictos al actualizar el add-on (por ejemplo, si ya existe un add-on con el mismo nombre)

  depends_on = [aws_eks_cluster.eks_cluster]

  timeouts {
    create = local.eks_addons_create_timeout # Tiempo máximo de espera para la creación del add-on
  }
}

resource "aws_eks_addon" "kube_proxy" { # Instala el add-on kube-proxy en el cluster de EKS
  cluster_name                = var.eks.cluster_name
  addon_name                  = "kube-proxy"
  addon_version               = var.eks.addons.kube_proxy.version
  resolve_conflicts_on_create = local.eks_addons_resolve_conflicts_on_create
  resolve_conflicts_on_update = local.eks_addons_resolve_conflicts_on_update

  depends_on = [aws_eks_cluster.eks_cluster]

  timeouts {
    create = local.eks_addons_create_timeout
  }
}

resource "aws_eks_addon" "eks_node_monitoring_agent" { # Instala el add-on eks-node-monitoring-agent en el cluster de EKS
  cluster_name                = var.eks.cluster_name
  addon_name                  = "eks-node-monitoring-agent"
  addon_version               = var.eks.addons.eks_node_monitoring_agent.version
  resolve_conflicts_on_create = local.eks_addons_resolve_conflicts_on_create
  resolve_conflicts_on_update = local.eks_addons_resolve_conflicts_on_update

  depends_on = [aws_eks_cluster.eks_cluster]

  timeouts {
    create = local.eks_addons_create_timeout
  }
}
