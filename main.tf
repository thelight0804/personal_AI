provider "aws" {
  region = "ap-northeast-1"
}

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value       = data.aws_caller_identity.current.account_id
  description = "현재 Terraform이 사용하는 AWS 계정 ID"
}

output "aws_region" {
  value       = "ap-northeast-1"
  description = "Terraform이 리소스를 만들 AWS 리전"
}

# Terraform 상태용 S3 버킷 생성
resource "aws_s3_bucket" "personal-ai-tfstate-048013208539" {
  bucket = "personal-ai-tfstate-048013208539"
}

# Public Access 설정
resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.personal-ai-tfstate-048013208539.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# tfstate 파일 versioning
resource "aws_s3_bucket_versioning" "personal-ai-tfstate" {
  bucket = aws_s3_bucket.personal-ai-tfstate-048013208539.id
  versioning_configuration {
    status = "Enabled"
  }
}