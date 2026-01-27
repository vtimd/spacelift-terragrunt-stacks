data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "demo" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = var.instance_type
  associate_public_ip_address = false
  
  monitoring = var.enable_monitoring
  
  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
  }
  
  tags = {
    Name = var.instance_name
  }
}
