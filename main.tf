module "vpc" {
  source                = "./modules/vpc"
  project_name          = var.project_name
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidr   = var.private_subnet_cidr
}

module "security" {
  source           = "./modules/security"
  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = var.allowed_ssh_cidr
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
}

module "ec2" {
  source            = "./modules/ec2"
  subnet_id         = module.vpc.private_subnet_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  ec2_sg_id         = module.security.ec2_sg_id
  target_group_arn  = module.alb.target_group_arn
}
