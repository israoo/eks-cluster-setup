resource "aws_vpc" "eks_vpc" { # Crea una VPC para EKS
  cidr_block           = var.vpc.cidr_block
  enable_dns_hostnames = true # Permite que los nodos de EKS tengan nombres de dominio de AWS por ejemplo: ec2-192-168-1-1.ec2.internal
  enable_dns_support   = true # Requerido para que los nodos de EKS puedan resolver nombres de dominio de AWS

  tags = {
    Environment = var.environment
    Name        = "eks-vpc"
  }
}
