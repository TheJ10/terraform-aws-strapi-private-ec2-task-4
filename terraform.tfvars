aws_region          = "ap-south-1"
project_name        = "strapi-private"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr = "10.0.3.0/24"
instance_type       = "t3.small"
key_name = "task4-key"
allowed_ssh_cidr = "0.0.0.0/32"

