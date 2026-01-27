# root.hcl

locals {
  # Extract environment from path - works with both local and Spacelift
  path_parts  = split("/", get_terragrunt_dir())
  environment = try(
    element([for part in local.path_parts : part if contains(["dev", "prod"], part)], 0),
    "unknown"
  )
  
  aws_region = "us-east-1"
  
  common_tags = {
    ManagedBy   = "Spacelift"
    Environment = local.environment
    Project     = "Terragrunt-Demo"
  }
}

remote_state {
  backend = "s3"
  
  config = {
    bucket         = "spacelift-terragrunt-state-${local.environment}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = "spacelift-terragrunt-locks"
  }
  
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  
  default_tags {
    tags = ${jsonencode(local.common_tags)}
  }
}
EOF
}
