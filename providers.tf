provider "aws" {
  default_tags {
    tags = {
      Environment = var.tags.environment
      Service     = var.tags.service
    }
  }
}
