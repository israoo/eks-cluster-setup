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
