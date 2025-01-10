MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==BOUNDARY=="

--==BOUNDARY==
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    name: ${eks_cluster_name}
    apiServerEndpoint: ${eks_cluster_endpoint}
    certificateAuthority: ${eks_cluster_ca}
    cidr: ${vpc_cidr}

--==BOUNDARY==--
