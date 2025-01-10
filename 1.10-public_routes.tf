resource "aws_route" "igw_route" {                               # Crea una ruta hacia Internet
  route_table_id         = aws_route_table.public_route_table.id # Asocia la ruta con la tabla de rutas pública
  destination_cidr_block = "0.0.0.0/0"                           # Define la ruta para todo el tráfico de salida hacia Internet
  gateway_id             = aws_internet_gateway.eks_igw.id       # Asocia la ruta con el Internet Gateway

  depends_on = [
    aws_route_table.public_route_table,
    aws_internet_gateway.eks_igw
  ]
}
