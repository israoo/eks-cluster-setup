variable "aws_user" {
  description = "AWS user name."
  type        = string
}

variable "eks" {
  description = "EKS cluster configuration."
  type = object({
    cluster_name      = string
    cluster_version   = string
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
