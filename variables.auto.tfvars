aws_user = "cloud_user"

eks = {
  cluster_name      = "eks-cluster"
  cluster_version   = "1.32"
  service_ipv4_cidr = "172.20.0.0/16"
  worker_nodes = {
    capacity_type = "ON_DEMAND"
    ebs_volume = {
      size = 20
      type = "gp3"
    }
    instance_type              = "t3a.medium"
    max_pods_per_node          = 17
    max_size                   = 3
    max_unavailable_percentage = 50
    min_size                   = 1
    node_group_name            = "eks-managed-node-group"
  }
}

tags = {
  environment = "Prod"
  service     = "demo"
}

vpc = {
  cidr_block = "10.0.0.0/16"
  private_subnet_1 = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "us-east-1a"
  }
  private_subnet_2 = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  }
  private_subnet_3 = {
    cidr_block        = "10.0.3.0/24"
    availability_zone = "us-east-1c"
  }
  public_subnet_1 = {
    cidr_block        = "10.0.4.0/24"
    availability_zone = "us-east-1a"
  }
  public_subnet_2 = {
    cidr_block        = "10.0.5.0/24"
    availability_zone = "us-east-1b"
  }
  public_subnet_3 = {
    cidr_block        = "10.0.6.0/24"
    availability_zone = "us-east-1c"
  }
}
