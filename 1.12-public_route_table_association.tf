resource "aws_route_table_association" "public_association_1" { # Asocia la subred pública 1 con la tabla de rutas pública
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id

  depends_on = [
    aws_subnet.public_subnet_1,
    aws_route_table.public_route_table
  ]
}

resource "aws_route_table_association" "public_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id

  depends_on = [
    aws_subnet.public_subnet_2,
    aws_route_table.public_route_table
  ]
}

resource "aws_route_table_association" "public_association_3" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_route_table.id

  depends_on = [
    aws_subnet.public_subnet_3,
    aws_route_table.public_route_table
  ]
}
