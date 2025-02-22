resource "aws_eks_cluster" "eks_cluster" { # Crea un clúster de EKS
  name     = var.eks.cluster_name
  version  = var.eks.cluster_version
  role_arn = aws_iam_role.eks_control_plane_iam_role.arn # Asocia el rol de IAM del control plane de EKS con el clúster

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP" # Habilita la autenticación a la API del clúster de EKS a través de la autenticación de IAM y el uso de un ConfigMap (aws-auth) para mapear usuarios y roles a grupos de kubernetes
  }

  vpc_config {
    security_group_ids = [
      aws_security_group.eks_control_plane_sg.id # Asocia el grupo de seguridad del control plane de EKS con el clúster
    ]
    subnet_ids = [ # Asocia las subredes de la VPC con el clúster
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id,
      aws_subnet.private_subnet_3.id,
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id,
      aws_subnet.public_subnet_3.id,
    ]
    endpoint_public_access  = true # Habilita el acceso público al API server de EKS (para acceder al clúster desde internet)
    endpoint_private_access = true # Habilita el acceso privado al API server de EKS (para acceder al clúster desde la VPC)
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.eks.service_ipv4_cidr # CIDR block para el rango de IPs de los servicios de Kubernetes
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"] # Habilita los logs de los componentes del control plane de EKS

  tags = {
    Name = var.eks.cluster_name
  }

  depends_on = [
    aws_iam_role.eks_control_plane_iam_role,
    aws_security_group.eks_control_plane_sg,
    aws_subnet.private_subnet_1,
    aws_subnet.private_subnet_2,
    aws_subnet.private_subnet_3,
  ]
}
