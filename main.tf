module "s3" {
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

module "init-build" {
    source = "./modules/init-build"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    environment = var.environment
    app_name = var.app_name
    working_dir = "${path.root}/app"
    image_tag = var.image_tag
}

module "ecs" {
    source = "./modules/ecs"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    environment = var.environment
    app_name = var.app_name
    image_tag = var.image_tag
    ecr_repository_url = module.ecr.ecr_repository_url
    taskdef_template = "${path.root}/modules/ecs/cb_app.json.tpl"
    app_count = var.app_count
    aws_subnet_private_id = module.vpc.subnets
    aws_vps_main_id = module.vpc.vpc_id
    aws_security_group_lb_id = module.vpc.security_group_lb_id
    target_group_arn = module.vpc.target_group_arn
}

module "codebuild" {
    source = "./modules/codebuild"
    aws_region = var.aws_region
    aws_profile = var.aws_profile
    environment = var.environment
    app_name = var.app_name
    vpc_id = module.vpc.vpc_id
    subnets = module.vpc.subnets
    github_oauth_token = var.github_oauth_token
    repo_url = var.repo_url
    branch_pattern = var.branch_pattern
    git_trigger_event = var.git_trigger_event
    build_spec_file = "./config/buildspec.yml"
}
