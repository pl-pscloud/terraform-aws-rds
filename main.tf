resource "aws_db_instance" "pscloud-rds-instance" {

  identifier              = "${var.pscloud_company}-rds-instance-${var.pscloud_env}"

  allocated_storage       = var.pscloud_storage
  storage_type            = "gp2"
  engine                  = var.pscloud_engine
  engine_version          = var.pscloud_engine_version
  instance_class          = var.pscloud_rds_instance_type

  name                    = var.pscloud_dbname
  username                = var.pscloud_dbuser
  password                = var.pscloud_dbpass
  db_subnet_group_name    = var.pscloud_rds_subnet_group.name
  parameter_group_name    = aws_db_parameter_group.pscloud-rds-parameter-gr.name

  vpc_security_group_ids  = [ var.pscloud_sec_gr ]

  skip_final_snapshot     = true

  tags = {
      Name                = "${var.pscloud_company}_rds_instance_for_${var.pscloud_purpose}_${var.pscloud_env}"
  }

}

resource "aws_db_parameter_group" "pscloud-rds-parameter-gr" {
  name                    = "${var.pscloud_company}-rds-parameter-gr-${var.pscloud_env}"
  family                  = var.pscloud_engine_version

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
