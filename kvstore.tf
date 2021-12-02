resource "alicloud_kvstore_instance" "redis" {
  instance_class    = "redis.master.small.default"
  instance_name     = var.kvstore_instance_name
  vswitch_id        = module.vpc.this_vswitch_ids.0
  private_ip        = "172.16.0.102"
  security_ips      = ["172.16.0.10,172.17.0.10"]
  instance_type     = "Redis"
  engine_version    = "5.0"
  resource_group_id = alicloud_resource_manager_resource_group.idp-rg.id
  tags              = var.kvstore_instance_tags
}

resource "alicloud_kvstore_account" "dbuser" {
  account_name     = var.kvstore_account_name
  account_password = var.kvstore_account_password
  instance_id      = alicloud_kvstore_instance.redis.id
}
