MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="//"

--//
Content-Type: application/node.eks.aws

---
apiVersion: node.eks.aws/v1alpha1
kind: NodeConfig
spec:
  cluster:
    apiServerEndpoint: ${eks_cluster_endpoint}
    certificateAuthority: ${eks_cluster_ca}
    cidr: ${eks_cluster_cidr}
    name: ${eks_cluster_name}
  kubelet:
    config:
      maxPods: ${eks_max_pods_per_node}
      clusterDNS:
      - ${eks_cluster_dns_ip}
    flags:
    - "--node-labels=name=${eks_node_group_name},eks.amazonaws.com/nodegroup-image=${eks_node_ami_id},eks.amazonaws.com/capacityType=${eks_node_capacity_type},eks.amazonaws.com/nodegroup=${eks_node_group_name}"

--//--
