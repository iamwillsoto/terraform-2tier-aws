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
