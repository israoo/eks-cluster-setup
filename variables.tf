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
