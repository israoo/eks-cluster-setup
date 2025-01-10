resource "aws_internet_gateway" "eks_igw" { # Crea un Internet Gateway
  vpc_id = aws_vpc.eks_vpc.id               # Asocia el Internet Gateway con la VPC

  tags = {
    Environment = var.environment
    Name        = "eks-internet-gateway"
  }

  depends_on = [aws_vpc.eks_vpc]
}
