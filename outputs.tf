output "pscloud_db_endpoint" {
  value = aws_db_instance.pscloud-rds-instance.endpoint
}

output "pscloud_dbuser" {
  value = random_password.pscloud-user.result
}

output "pscloud_dbpass" {
  value = random_password.pscloud-password.result
}