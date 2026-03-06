remote_state {
  backend = "s3"

  config = {
    bucket         = "terraform-state-000000000000-ap-southeast-2"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-2"
    # dynamodb_table = "terraform-lock-000000000000-ap-southeast-2"
    encrypt        = true
    use_lockfile   = true

    endpoint                    = "http://localstack:4566"
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    force_path_style            = true
    skip_requesting_account_id  = true
  }
}


generate "provider" {
  path      = "gen_provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF

provider "aws" {
  region = "ap-southeast-2"

   
  endpoints {
    ec2              = "http://localstack:4566"
    s3               = "http://localstack:4566"
    iam              = "http://localstack:4566"
  }

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_region_validation      = true

}
EOF
}

generate "backend" {
  path      = "gen_backend.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  backend "s3" {}
}
EOF
}


locals {
  aws_account_id = "000000000000"
  aws_region     = "ap-southeast-2"
}