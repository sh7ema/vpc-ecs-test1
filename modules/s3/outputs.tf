# output "s3_bucket_arn" {
#   value = aws_s3_bucket.terraform_state.arn
#   description = "The ARN of the S3 bucket"
# }

# output "dynamodb_table_name" {
#   value = aws_dynamodb_table.terraform_locks.name
#   description = "The name of the DynamoDB table"
# }

output "bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket_domain_name
}