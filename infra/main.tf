module "network" {
  source = "./modules/network"

  name_prefix = var.name_prefix
  vpc_cidr    = var.vpc_cidr
  az_count    = 2
}

module "security" {
  source = "./modules/security"

  name_prefix = var.name_prefix
  vpc_id      = module.network.vpc_id
}

module "rds" {
  source = "./modules/rds"

  name_prefix        = var.name_prefix
  private_subnet_ids = module.network.private_subnet_ids
  rds_sg_id          = module.security.rds_sg_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}
