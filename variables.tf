variable "aws_region" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(string)
}
variable "private_subnet_cidr" {}
variable "instance_type" {}
variable "key_name" {}
variable "allowed_ssh_cidr" {}
