terraform {
  backend "s3" {}
}

provider "aws" {
  region                      = "ap-southeast-2"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3       = "http://localstack:4566"
    dynamodb = "http://localstack:4566"
    eks      = "http://localstack:4566"
    ec2      = "http://localstack:4566"
    iam      = "http://localstack:4566"
    sts      = "http://localstack:4566"
  }
}

resource "aws_iam_role" "eks" {
  name = "local-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "this" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_security_group" "this" {
  vpc_id = aws_vpc.this.id
}

provider "kubernetes" {
 
  config_context = "kind-local-eks"
}