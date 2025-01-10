resource "aws_eks_node_group" "eks_node_group" { # Crea un grupo de nodos administrados para los worker nodes de EKS
  cluster_name    = var.eks.cluster_name
  node_group_name = var.eks.worker_nodes.node_group_name
  node_role_arn   = aws_iam_role.eks_worker_node_iam_role.arn # Asocia el rol IAM de los worker nodes de EKS
  subnet_ids = [                                              # Asocia las subredes privadas de la VPC con el grupo de nodos (para que los worker nodes se desplieguen en las subredes privadas)
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
    aws_subnet.private_subnet_3.id,
  ]

  scaling_config { # Configura el escalado automático de los worker nodes (para ajustar la cantidad de worker nodes según la demanda)
    desired_size = var.eks.worker_nodes.desired_capacity
    min_size     = var.eks.worker_nodes.min_size
    max_size     = var.eks.worker_nodes.max_size
  }

  launch_template { # Asocia el launch template con el grupo de nodos (para definir la configuración de los worker nodes)
    id      = aws_launch_template.eks_worker_node_template.id
    version = aws_launch_template.eks_worker_node_template.latest_version
  }

  update_config {                                                                # Configura la actualización de los worker nodes durante una actualización del grupo de nodos
    max_unavailable_percentage = var.eks.worker_nodes.max_unavailable_percentage # Porcentaje máximo de worker nodes que pueden estar no disponibles durante una actualización
  }

  labels = { # Asigna etiquetas a los worker nodes
    name = var.eks.worker_nodes.node_group_name
  }

  tags = {
    Name = "eks-node-group"
  }

  depends_on = [
    aws_iam_role.eks_worker_node_iam_role,
    aws_launch_template.eks_worker_node_template,
    aws_subnet.private_subnet_1,
    aws_subnet.private_subnet_2,
    aws_subnet.private_subnet_3,
  ]
}
