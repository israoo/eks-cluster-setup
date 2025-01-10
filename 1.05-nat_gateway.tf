resource "aws_nat_gateway" "nat_gateway_1" {    # Crea un NAT Gateway en la subred pública 1
  subnet_id     = aws_subnet.public_subnet_1.id # Asocia el NAT Gateway con la subred pública
  allocation_id = aws_eip.nat_eip_1.id          # Asocia la dirección IP elástica con el NAT Gateway

  tags = {
    Environment = var.environment
    Name        = "eks-nat-gateway-1"
  }

  depends_on = [
    aws_subnet.public_subnet_1,
    aws_eip.nat_eip_1
  ]
}

resource "aws_nat_gateway" "nat_gateway_2" {
  subnet_id     = aws_subnet.public_subnet_2.id
  allocation_id = aws_eip.nat_eip_2.id

  tags = {
    Environment = var.environment
    Name        = "eks-nat-gateway-2"
  }

  depends_on = [
    aws_subnet.public_subnet_2,
    aws_eip.nat_eip_2
  ]
}

resource "aws_nat_gateway" "nat_gateway_3" {
  subnet_id     = aws_subnet.public_subnet_3.id
  allocation_id = aws_eip.nat_eip_3.id

  tags = {
    Environment = var.environment
    Name        = "eks-nat-gateway-3"
  }

  depends_on = [
    aws_subnet.public_subnet_3,
    aws_eip.nat_eip_3
  ]
}