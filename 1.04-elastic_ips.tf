resource "aws_eip" "nat_eip_1" { # Crea una dirección IP elástica para el NAT Gateway
  domain = "vpc"                 # Especifica que la dirección IP elástica es para una VPC

  tags = {
    Name = "eks-nat-eip-1"
  }
}

resource "aws_eip" "nat_eip_2" {
  domain = "vpc"

  tags = {
    Name = "eks-nat-eip-2"
  }
}

resource "aws_eip" "nat_eip_3" {
  domain = "vpc"

  tags = {
    Name = "eks-nat-eip-3"
  }
}
