# terragrunt.hcl (root)

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
