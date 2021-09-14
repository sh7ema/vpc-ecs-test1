output "ecr_repository_url" {
  value = module.ecr.ecr_repository_url
}

output "alb_hostname" {
  value = module.vpc.alb_hostname
}