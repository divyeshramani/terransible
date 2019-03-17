variable "aws_profile" {}
variable "key_name" {}

variable "public_key_path" {}

variable "aws_region" {}
variable "cidr" {}

variable "cidrs" {
  type = "map"
}

variable "localip" {}

variable "instance_type" {}

variable "ami_id_ansible" {}

variable "ami_id_chef" {}

variable "ami_rhel" {}

variable "ami_ubuntu" {}
