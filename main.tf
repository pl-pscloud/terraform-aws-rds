resource "random_password" "pscloud-password" {
  length      = 16
  special     = false
}

resource "random_password" "pscloud-user" {
  length = 16
  special = false
}

resource "aws_db_instance" "pscloud-rds-instance" {

  identifier              = "${var.pscloud_company}-rds-instance-${var.pscloud_env}-${var.pscloud_purpose}"

  allocated_storage       = var.pscloud_storage
  max_allocated_storage   = var.pscloud_storage_max
  storage_type            = "gp2"

  storage_encrypted       = var.pscloud_storage_encrypted
  kms_key_id              = var.pscloud_kms_key_arn

  backup_retention_period = var.pscloud_backup_retention_period

  engine                  = var.pscloud_engine
  engine_version          = var.pscloud_engine_version
  instance_class          = var.pscloud_rds_instance_type


  username                = random_password.pscloud-user.result
  password                = random_password.pscloud-password.result

  db_subnet_group_name    = aws_db_subnet_group.pscloud-rds-subnet-group.name
  parameter_group_name    = (var.pscloud_create_parameter_group == true) ? aws_db_parameter_group.pscloud-rds-parameter-gr[0].name : ""

  vpc_security_group_ids  = var.pscloud_sec_gr

  skip_final_snapshot     = true

  snapshot_identifier     = var.pscloud_snapshot_identifier

  apply_immediately       = var.pscloud_apply_immediately

  tags = {
      Name                = "${var.pscloud_company}_rds_instance_for_${var.pscloud_purpose}_${var.pscloud_env}"
  }

}

resource "aws_db_subnet_group" "pscloud-rds-subnet-group" {
  subnet_ids = var.pscloud_rds_subnet_group[*].id
}

resource "aws_db_parameter_group" "pscloud-rds-parameter-gr" {
  count                   = (var.pscloud_create_parameter_group == true) ? 1 : 0

  name                    = "${var.pscloud_company}-rds-parameter-gr-${var.pscloud_env}-${var.pscloud_purpose}"
  family                  = join("", [ var.pscloud_engine, var.pscloud_engine_version ])

  parameter {
    name                  = "character_set_server"
    value                 = "utf8"
  }

  parameter {
    name                  = "character_set_client"
    value                 = "utf8"
  }

  parameter {
    name                  = "max_allowed_packet"
    value                 = "1073741824"
  }

  tags = {
    Name                  = "${var.pscloud_company}_rds_parameter_gr_${var.pscloud_env}"
  }
}
