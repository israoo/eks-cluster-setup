data "aws_ssm_parameter" "eks_ami" { # Obtiene el ID de la AMI recomendada para los worker nodes de EKS
  name = "/aws/service/eks/optimized-ami/${var.eks.cluster_version}/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

resource "aws_launch_template" "eks_worker_node_template" { # Crea una plantilla de lanzamiento para los worker nodes de EKS
  name_prefix   = "eks-worker-node-template"
  instance_type = var.eks.worker_nodes.instance_type
  image_id      = data.aws_ssm_parameter.eks_ami.value
  user_data = base64encode(templatefile("${path.module}/eks_user_data.sh", { # Configura el script de inicio de los worker nodes de EKS
    eks_cluster_name     = var.eks.cluster_name
    eks_cluster_endpoint = aws_eks_cluster.eks_cluster.endpoint
    eks_cluster_ca       = aws_eks_cluster.eks_cluster.certificate_authority.0.data
    vpc_cidr             = var.vpc.cidr_block
  }))

  block_device_mappings { # Configura el volumen EBS (disco duro) para los worker nodes
    device_name = "/dev/xvda"
    ebs {
      volume_size = var.eks.worker_nodes.ebs_volume.size
      volume_type = var.eks.worker_nodes.ebs_volume.type
    }
  }

  network_interfaces {                                                        # Configura la interfaz de red de los worker nodes
    associate_public_ip_address = false                                       # No se asigna una IP pública
    security_groups             = [aws_security_group.eks_worker_nodes_sg.id] # Asocia el grupo de seguridad de los worker nodes de EKS
  }

  metadata_options {
    http_endpoint               = "enabled"  # Habilita el acceso a la metadata del worker node disponible en el IMDS (Instance Metadata Service) de AWS (para que los pods puedan obtener información sobre el nodo, obtener credenciales temporales del rol de IAM asociado a la instancia, etc)
    http_tokens                 = "required" # Obliga a que todas las solicitudes al IMDS incluyan un token de seguridad (para evitar ataques de SSRF - Server-Side Request Forgery)
    http_put_response_hop_limit = 2          # Limita la cantidad de saltos permitidos en las respuestas HTTP (solo aplicaciones en el nodo o en un contenedor pueden acceder a la metadata del nodo)
  }

  monitoring {
    enabled = true # Habilita el monitoreo detallado de los worker nodes de EKS
  }

  tag_specifications { # Agrega tags a los recursos creados por la plantilla de lanzamiento
    resource_type = "instance"
    tags = {
      Environment = var.environment
      Role        = "worker-node"
    }
  }

  tags = {
    Environment = var.environment
    Name        = "eks-worker-node-template"
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_security_group.eks_worker_nodes_sg
  ]
}
