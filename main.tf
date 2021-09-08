module "s3_terraform_state" {
    source = "./modules/s3"
    bucket_name = var.bucket_name
}

module "vpc" {
    source = "./modules/vpc"
    bucket_name = var.bucket_name
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    app_name = var.app_name
}