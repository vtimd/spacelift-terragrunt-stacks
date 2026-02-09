include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  instance_name     = "prod-demo-instance"
  instance_type     = "t3.small"
  environment       = "prod"
  enable_monitoring = true
  root_volume_size  = 30
}
