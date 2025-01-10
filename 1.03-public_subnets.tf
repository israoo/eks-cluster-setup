resource "aws_subnet" "public_subnet_1" {      # Crea la subred pública 1
  vpc_id                  = aws_vpc.eks_vpc.id # Asocia la subred con la VPC
  cidr_block              = var.vpc.public_subnet_1.cidr_block
  availability_zone       = var.vpc.public_subnet_1.availability_zone
  map_public_ip_on_launch = true # Permite que las instancias en la subred obtengan una IP pública

  tags = {
    Name                     = "eks-public-subnet-1"
    "kubernetes.io/role/elb" = "1" # Permite que los servicios de Kubernetes de tipo LoadBalancer se desplieguen en esta subred
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.vpc.public_subnet_2.cidr_block
  availability_zone       = var.vpc.public_subnet_2.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name                     = "eks-public-subnet-2"
    "kubernetes.io/role/elb" = "1"
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.vpc.public_subnet_3.cidr_block
  availability_zone       = var.vpc.public_subnet_3.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name                     = "eks-public-subnet-3"
    "kubernetes.io/role/elb" = "1"
  }

  depends_on = [aws_vpc.eks_vpc]
}
