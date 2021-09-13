module "s3_terraform_state" {
    source = "./modules/s3"
    bucket_name = var.bucket_name
}

module "vpc" {
    source = "./modules/vpc"
    # bucket_name = var.bucket_name
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    app_name = var.app_name
    environment = var.environment
}

# module "rds" {
#     source = "./modules/rds"
#     aws_region = var.aws_region
#     aws_profile = var.aws_profile
#     app_name = var.app_name
#     environment = var.environment
#     database_name = var.database_name
#     master_username = var.master_username
#     master_password = var.master_password
#     subnet_ids = module.vpc.subnets
    
# }

module "ecr" {
    source = "./modules/ecr"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    environment = var.environment
    app_name = var.app_name
}