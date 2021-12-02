# resource "alicloud_eci_container_group" "this" {
#   container_group_name = var.container_group_name
#   cpu                  = var.container_group_cpu
#   memory               = var.container_group_memory
#   restart_policy       = "OnFailure"
#   security_group_id    = alicloud_security_group.idp-sg.id
#   vswitch_id           = module.vpc.this_vswitch_ids.0
#   resource_group_id    = alicloud_resource_manager_resource_group.idp-rg.id
#   tags = {
#     TF = "create"
#   }

#   containers {
#     image             = var.container_image
#     name              = var.container_name
#     image_pull_policy = "IfNotPresent"
#     ports {
#       port     = 443
#       protocol = "TCP"
#     }
#   }
# }
