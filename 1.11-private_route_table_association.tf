resource "aws_route_table_association" "private_association_1" { # Asocia la subred privada 1 con la tabla de rutas privada 1
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table_1.id

  depends_on = [
    aws_subnet.private_subnet_1,
    aws_route_table.private_route_table_1
  ]
}

resource "aws_route_table_association" "private_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table_2.id

  depends_on = [
    aws_subnet.private_subnet_2,
    aws_route_table.private_route_table_2
  ]
}

resource "aws_route_table_association" "private_association_3" {
  subnet_id      = aws_subnet.private_subnet_3.id
  route_table_id = aws_route_table.private_route_table_3.id

  depends_on = [
    aws_subnet.private_subnet_3,
    aws_route_table.private_route_table_3
  ]
}
