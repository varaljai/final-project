output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "rds_endpoint" {
  description = "The RDS MySQL database endpoint"
  value       = aws_db_instance.mysql.endpoint
}

output "s3_bucket_name" {
  description = "The name of the S3 bucket for backups"
  value       = aws_s3_bucket.backups.bucket
}

output "ssh_private_key" {
  description = "The generated SSH private key (sensitive)"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}
