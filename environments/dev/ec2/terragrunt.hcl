include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  instance_name     = "dev-demo-instance"
  instance_type     = "t3.micro"
  environment       = "dev"
  enable_monitoring = false
  root_volume_size  = 8
}
