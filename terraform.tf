terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  required_version = ">= 1.2"

  backend "s3" {
    bucket       = "personal-ai-tfstate-048013208539"
    key          = "terraform.tfstate"
    region       = "ap-northeast-1"
    use_lockfile = true
  }
}