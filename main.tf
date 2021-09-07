module "s3_terraform_state" {
  source = "./modules/s3"
  bucket_name = var.bucket_name
}

module "vps" {
    source = "./modules/vps"
    remote_state_bucket = var.bucket_name
}