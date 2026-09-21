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