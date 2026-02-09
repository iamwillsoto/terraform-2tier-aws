output "vpc_id" {
  value = module.network.vpc_id
}

output "alb_sg_id" {
  value = module.security.alb_sg_id
}

output "web_sg_id" {
  value = module.security.web_sg_id
}

output "rds_sg_id" {
  value = module.security.rds_sg_id
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}
