module "s3_terraform_state" {
    source = "./modules/s3"
    bucket_name = var.bucket_name
}

module "vpc" {
    source = "./modules/vpc"
    bucket = var.bucket_name
}