resource "aws_security_group" "eks_control_plane_sg" { # Crea un grupo de seguridad para el control plane de EKS
  name   = "eks-control-plane-sg"
  vpc_id = aws_vpc.eks_vpc.id # Asocia el grupo de seguridad con la VPC

  ingress { # Permite el tráfico entrante por el puerto 443/TCP desde cualquier dirección IP (necesario para que el api server de EKS pueda ser accedido)
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress { # Permite el tráfico saliente desde cualquier puerto y protocolo hacia cualquier dirección IP (necesario para que el control plane pueda comunicarse con los worker nodes)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-control-plane-sg"
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_security_group" "eks_worker_nodes_sg" { # Crea un grupo de seguridad para los worker nodes de EKS
  name   = "eks-worker-nodes-sg"
  vpc_id = aws_vpc.eks_vpc.id # Asocia el grupo de seguridad con la VPC

  ingress { # Permite el tráfico entrante por el puerto 10250/TCP desde la VPC (necesario para que el control plane pueda comunicarse con los worker nodes)
    from_port   = 10250
    to_port     = 10250
    protocol    = "tcp"
    cidr_blocks = [var.vpc.cidr_block]
  }

  egress { # Permite el tráfico saliente desde cualquier puerto y protocolo hacia cualquier dirección IP (necesario para que los worker nodes puedan comunicarse con el control plane y otros servicios de AWS o internet)
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-worker-nodes-sg"
  }

  depends_on = [aws_vpc.eks_vpc]
}
