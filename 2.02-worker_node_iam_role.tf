resource "aws_iam_role" "eks_worker_node_iam_role" { # Crea un rol de IAM para los worker nodes de EKS
  name = "eks-worker-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })

  tags = {
    Name = "eks-worker-node-role"
  }
}

resource "aws_iam_role_policy_attachment" "eks_worker_policy_attachment" { # Adjunta una política de IAM al rol de los worker nodes de EKS
  role       = aws_iam_role.eks_worker_node_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" # Necesario para que los worker nodes puedan comunicarse con el control plane de EKS (por ejemplo, para registrar nodos, obtener metadatos, etc.)
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy" # Necesario para que los worker nodes puedan configurar la red de contenedores de EKS (por ejemplo, crear interfaces de red, asignar direcciones IP, etc.)
}

resource "aws_iam_role_policy_attachment" "eks_ecr_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly" # Necesario para que los worker nodes puedan descargar imágenes de contenedores desde ECR (por ejemplo, para ejecutar pods)
}

resource "aws_iam_role_policy_attachment" "eks_ssm_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" # Necesario para que los worker nodes puedan registrarse en SSM (por ejemplo, para administración remota, inspección de configuraciones, etc.)
}

resource "aws_iam_role_policy_attachment" "eks_cw_policy_attachment" {
  role       = aws_iam_role.eks_worker_node_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy" # Necesario para que los worker nodes puedan enviar métricas y logs a CloudWatch (por ejemplo, para monitorear el rendimiento, depurar problemas, etc.)
}
