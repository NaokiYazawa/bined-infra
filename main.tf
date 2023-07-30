terraform {
  # Assumes s3 bucket and dynamo DB table already set up
  backend "s3" {
    bucket         = "bined-tf-state"
    key            = "terraform.tfstate"
    region         = "ap-northeast-1"
    dynamodb_table = "bined-tf-state-locking"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

locals {
  common_name = "bined-hasura"
}
