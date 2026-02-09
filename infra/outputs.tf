output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "instance_ids" {
  value = module.compute.instance_ids
}
