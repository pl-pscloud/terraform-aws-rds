variable "pscloud_env" {}
variable "pscloud_company" {}
variable "pscloud_purpose" {}

variable "pscloud_rds_instance_type" {}
variable "pscloud_storage" {}
variable "pscloud_storage_encrypted" { default = false }
variable "pscloud_kms_key_arn" { default = "" }

variable "pscloud_engine" {}
variable "pscloud_engine_version" {}

variable "pscloud_sec_gr" {}
variable "pscloud_rds_subnet_group" {}
