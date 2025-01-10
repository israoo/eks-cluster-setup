resource "aws_route_table" "private_route_table_1" { # Crea la tabla de rutas privada 1
  vpc_id = aws_vpc.eks_vpc.id                        # Asocia la tabla de rutas privada con la VPC

  tags = {
    Environment = var.environment
    Name        = "eks-private-route-table-1"
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Environment = var.environment
    Name        = "eks-private-route-table-2"
  }

  depends_on = [aws_vpc.eks_vpc]
}

resource "aws_route_table" "private_route_table_3" {
  vpc_id = aws_vpc.eks_vpc.id

  tags = {
    Environment = var.environment
    Name        = "eks-private-route-table-3"
  }

  depends_on = [aws_vpc.eks_vpc]
}
