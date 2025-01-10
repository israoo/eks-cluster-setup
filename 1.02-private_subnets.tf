resource "aws_subnet" "private_subnet_1" {     # Crea la subred privada 1
  vpc_id                  = aws_vpc.eks_vpc.id # Asocia la subred con la VPC
  cidr_block              = var.vpc.private_subnet_1.cidr_block
  availability_zone       = var.vpc.private_subnet_1.availability_zone
  map_public_ip_on_launch = false # No permite que las instancias en la subred obtengan una IP pública

  tags = {
    Environment                       = var.environment
    Name                              = "eks-private-subnet-1"
    "kubernetes.io/role/internal-elb" = "1" # Permite que los servicios de Kubernetes de tipo LoadBalancer (load balancers internos) se desplieguen en esta subred
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.vpc.private_subnet_2.cidr_block
  availability_zone       = var.vpc.private_subnet_2.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Environment                       = var.environment
    Name                              = "eks-private-subnet-2"
    "kubernetes.io/role/internal-elb" = "1"
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.vpc.private_subnet_3.cidr_block
  availability_zone       = var.vpc.private_subnet_3.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Environment                       = var.environment
    Name                              = "eks-private-subnet-3"
    "kubernetes.io/role/internal-elb" = "1"
  }

  depends_on = [aws_vpc.eks_vpc]
}
