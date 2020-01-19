output "pscloud_db_endpoint" {
  value = aws_db_instance.pscloud-rds-instance.endpoint
}

output "pscloud_dbuser" {
  value = var.pscloud_dbuser
}

output "pscloud_dbpass" {
  value = random_password.pscloud-password.result
}