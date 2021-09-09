provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

terraform {
  # backend "s3" {
  #   bucket = var.bucket_name
  # }
  required_providers {
    aws = {
      version = "~> 3.55"
    }
  }
}