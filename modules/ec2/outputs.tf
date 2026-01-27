output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.demo.id
}

output "instance_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.demo.private_ip
}
