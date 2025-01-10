resource "aws_iam_role" "eks_control_plane_iam_role" { # Crea un rol de IAM para el control plane de EKS
  name = "eks-control-plane-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
    }]
  })

  tags = {
    Name = "eks-control-plane-role"
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" { # Adjunta una política de IAM al rol del control plane de EKS
  role       = aws_iam_role.eks_control_plane_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy" # Necesario para que el control plane pueda administrar los recursos de AWS necesarios para operar el clúster (por ejemplo, instancias EC2, roles de IAM, etc.)
}

resource "aws_iam_role_policy_attachment" "eks_vpc_resource_controller_attachment" {
  role       = aws_iam_role.eks_control_plane_iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController" # Necesario para que el control plane pueda administrar los recursos de red (VPC) asociados al clúster (por ejemplo, subredes, ENIs, etc.)
}
