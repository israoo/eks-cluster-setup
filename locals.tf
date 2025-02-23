locals {
  aws_node = {
    namespace_name       = "kube-system"
    role_name            = "eks-vpc-cni-role"
    service_account_name = "aws-node"
  }

  ebs_csi_driver = {
    namespace_name       = "kube-system"
    role_name            = "eks-ebs-csi-driver-role"
    service_account_name = "ebs-csi-controller-sa"
  }

  eks_addons_resolve_conflicts_on_create = "OVERWRITE"
  eks_addons_resolve_conflicts_on_update = "OVERWRITE"
  eks_addons_create_timeout              = "2m"
  eks_cluster_dns_ip                     = cidrhost(var.eks.service_ipv4_cidr, 10)
  eks_cluster_oidc_issuer                = replace(data.tls_certificate.this.url, "https://", "")
  eks_oidc_client_id                     = "sts.amazonaws.com"
}
