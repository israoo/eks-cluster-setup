locals {
  eks_cluster_dns_ip = cidrhost(var.eks.service_ipv4_cidr, 10)
}
