variable "aws_user" {
  description = "AWS user name."
  type        = string
}

variable "eks" {
  description = "EKS cluster configuration."
  type = object({
    addons = object({
      aws_ebs_csi_driver = object({
        version = string
      })
      coredns = object({
        version = string
      })
      eks_node_monitoring_agent = object({
        version = string
      })
      kube_proxy = object({
        version = string
      })
      vpc_cni = object({
        version = string
      })
    })
    cluster_name    = string
    cluster_version = string
    ebs_storage_class = object({
      allow_volume_expansion = bool
      name                   = string
      reclaim_policy         = string
      type                   = string
      volume_binding_mode    = string
    })
    service_ipv4_cidr = string
    worker_nodes = object({
      capacity_type = string
      ebs_volume = object({
        size = number
        type = string
      })
      instance_type              = string
      max_pods_per_node          = number
      max_size                   = number
      max_unavailable_percentage = number
      min_size                   = number
      node_group_name            = string
      node_repair_enabled        = bool
    })
  })
}

variable "tags" {
  description = "Tags."
  type = object({
    environment = string
    service     = string
  })
}

variable "vpc" {
  description = "VPC configuration."
  type = object({
    cidr_block = string
    private_subnet_1 = object({
      cidr_block        = string
      availability_zone = string
    })
    private_subnet_2 = object({
      cidr_block        = string
      availability_zone = string
    })
    private_subnet_3 = object({
      cidr_block        = string
      availability_zone = string
    })
    public_subnet_1 = object({
      cidr_block        = string
      availability_zone = string
    })
    public_subnet_2 = object({
      cidr_block        = string
      availability_zone = string
    })
    public_subnet_3 = object({
      cidr_block        = string
      availability_zone = string
    })
  })
}
