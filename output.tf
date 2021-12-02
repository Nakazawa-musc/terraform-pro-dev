// リソースグループ
output "resource_group_id" {
  description = "The ID of the resource group"
  value       = alicloud_resource_manager_resource_group.idp-rg.id
}
output "resource_group_status" {
  description = "The status of the resource group"
  value       = alicloud_resource_manager_resource_group.idp-rg.status
}

output "resource_group_account_id" {
  description = "The ID of the Alibaba Cloud account to which the resource group belongs."
  value       = alicloud_resource_manager_resource_group.idp-rg.account_id
}

output "resource_group_create_date" {
  description = "The status of the resource group"
  value       = alicloud_resource_manager_resource_group.idp-rg.create_date
}

output "resource_group_region_statuses" {
  description = "The status of the resource group in all regions."
  value       = alicloud_resource_manager_resource_group.idp-rg.region_statuses
}

// VPC・VSwitch
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.this_vpc_id
}

output "vpc_cidr_block" {
  description = "The VPC cidr block"
  value       = module.vpc.this_vpc_cidr_block
}

output "vpc_tags" {
  description = "The tags of the VPC"
  value       = module.vpc.this_vpc_tags
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = module.vpc.this_vpc_name
}

// VSwitch
output "vswitch_ids" {
  description = "List of IDs of vswitch"
  value       = module.vpc.this_vswitch_ids
}
output "vswitch_tags" {
  description = "List of IDs of vswitch"
  value       = module.vpc.this_vswitch_tags
}

output "vswitch_cidr_block" {
  description = "The vswitch cidr block"
  value       = module.vpc.this_vswitch_cidr_blocks
}

output "vswitch_name" {
  description = "The name of vswitch"
  value       = module.vpc.this_vswitch_names
}

// SSHアクセスキーペア
output "instance_key_name" {
  description = "The name of the key pair."
  value       = alicloud_key_pair.key_pair.key_name
}

output "instance_fingerprint" {
  description = "The finger print of the key pair."
  value       = alicloud_key_pair.key_pair.finger_print
}

// ECSインスタンス
output "this_availability_zone" {
  description = ""
  value       = module.ecs_cluster.this_availability_zone
}

output "this_image_id" {
  description = ""
  value       = module.ecs_cluster.this_image_id
}

output "this_instance_type" {
  description = ""
  value       = module.ecs_cluster.this_instance_type
}

output "this_key_name" {
  description = ""
  value       = module.ecs_cluster.this_key_name
}

output "this_security_group_ids" {
  description = ""
  value       = module.ecs_cluster.this_security_group_ids
}

output "this_vswitch_id" {
  description = ""
  value       = module.ecs_cluster.this_vswitch_id
}

// ログ
output "this_log_project_name" {
  description = "The name of the log project"
  value       = concat(alicloud_log_project.this.*.name, [""])[0]
}

output "authn_log_store_index_field_search" {
  description = "The field search of the log store index"
  value       = concat(alicloud_log_store_index.authn.*.field_search, [[]])[0]
}

output "system_log_store_index_field_search" {
  description = "The field search of the log store index"
  value       = concat(alicloud_log_store_index.system.*.field_search, [[]])[0]
}

output "authn_log_store_index_full_text" {
  description = "The full text of the log store index"
  value       = concat(alicloud_log_store_index.authn.*.full_text, [[]])[0]
}

output "system_log_store_index_full_text" {
  description = "The full text of the log store index"
  value       = concat(alicloud_log_store_index.system.*.full_text, [[]])[0]
}

output "authn_log_store_name" {
  description = "The name of the log store"
  value       = concat(alicloud_log_store.authn.*.name, [""])[0]
}

output "system_log_store_name" {
  description = "The name of the log store"
  value       = concat(alicloud_log_store.system.*.name, [""])[0]
}
