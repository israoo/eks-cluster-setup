resource "aws_route" "nat_route_1" {                                # Crea una ruta para el tráfico de salida hacia Internet
  route_table_id         = aws_route_table.private_route_table_1.id # Asocia la ruta con la tabla de rutas privada
  destination_cidr_block = "0.0.0.0/0"                              # Define la ruta para todo el tráfico de salida hacia Internet
  nat_gateway_id         = aws_nat_gateway.nat_gateway_1.id         # Asocia la ruta con el NAT Gateway

  depends_on = [
    aws_route_table.private_route_table_1,
    aws_nat_gateway.nat_gateway_1
  ]
}

resource "aws_route" "nat_route_2" {
  route_table_id         = aws_route_table.private_route_table_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_2.id

  depends_on = [
    aws_route_table.private_route_table_2,
    aws_nat_gateway.nat_gateway_2
  ]
}

resource "aws_route" "nat_route_3" {
  route_table_id         = aws_route_table.private_route_table_3.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_3.id

  depends_on = [
    aws_route_table.private_route_table_3,
    aws_nat_gateway.nat_gateway_3
  ]
}
