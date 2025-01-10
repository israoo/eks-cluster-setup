resource "aws_route_table" "public_route_table" { # Crea la tabla de rutas pública
  vpc_id = aws_vpc.eks_vpc.id                     # Asocia la tabla de rutas pública con la VPC

  tags = {
    Environment = var.environment
    Name        = "eks-public-route-table"
  }

  depends_on = [aws_vpc.eks_vpc]
}
