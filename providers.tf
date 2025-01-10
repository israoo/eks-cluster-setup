provider "aws" {
  default_tags {
    tags = {
      Environment = var.environment
    }
  }
}
