provider "aws" {
    region = var.aws_region
    profile = var.aws_profile
}

terraform {
  # backend "s3" {
  #   encrypt = true
  #   bucket  = "flaskapp-dev-eu-central-1-shlema-1"
  #   region  = "eu-central-1"
  #   key     = "state"
  # }
  required_providers {
    aws = {
      version = "~> 3.55"
    }
  }
}