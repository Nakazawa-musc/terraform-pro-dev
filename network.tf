
// VPC・VSwitch
module "vpc" {
  source = "alibaba/vpc/alicloud"

  availability_zones = var.availability_zones
  create             = var.vpc_create
  destination_cidrs  = var.destination_cidrs
  nexthop_ids        = var.nexthop_ids
  resource_group_id  = alicloud_resource_manager_resource_group.idp-rg.id
  use_num_suffix     = var.vswitch_use_num_suffix

  vpc_cidr        = var.vpc_cidr
  vpc_description = var.vpc_description
  vpc_name        = var.vpc_name
  vpc_tags        = var.vpc_tags

  vswitch_cidrs       = var.vswitch_cidrs
  vswitch_description = var.vswitch_description
  vswitch_name        = var.vswitch_name
  vswitch_tags        = var.vswitch_tags
}

// セキュリティグループ
resource "alicloud_security_group" "idp-sg" {
  name                = var.security_group_name
  vpc_id              = module.vpc.this_vpc_id
  resource_group_id   = alicloud_resource_manager_resource_group.idp-rg.id
  description         = var.security_group_description
  security_group_type = var.security_group_type
  tags                = var.security_group_tags
}
resource "alicloud_security_group_rule" "http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 50
  security_group_id = alicloud_security_group.idp-sg.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 50
  security_group_id = alicloud_security_group.idp-sg.id
  cidr_ip           = "0.0.0.0/0"
}
resource "alicloud_security_group_rule" "ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 50
  security_group_id = alicloud_security_group.idp-sg.id
  cidr_ip           = "0.0.0.0/0"
}

// ロードバランサー
resource "alicloud_slb" "idp-slb" {
  internet_charge_type = var.slb_internet_charge_type
  resource_group_id    = alicloud_resource_manager_resource_group.idp-rg.id
  load_balancer_name   = var.slb_name
  load_balancer_spec   = var.slb_spec
  vswitch_id           = module.vpc.this_vswitch_ids.0
  address_type         = var.address_type
  tags                 = var.slb_tags
}

// 仮想サーバーグループ
resource "alicloud_slb_server_group" "idp-vsg" {
  load_balancer_id = alicloud_slb.idp-slb.id
  name             = var.virtual_server_group_name
  # delete_protection_validation = true
  servers {
    server_ids = module.ecs_cluster.this_instance_id
    port       = 80
    weight     = 100
    type       = "ecs"
  }
}

# create a server certificate
resource "alicloud_slb_server_certificate" "slb_server_cert" {
  name               = var.slb_server_cert_name
  server_certificate = var.slb_server_cert_certificate
  private_key        = var.slb_server_cert_privatekey
  resource_group_id  = alicloud_resource_manager_resource_group.idp-rg.id
}

// ロードバランサーリスナー
module "slb_listener" {
  source = "terraform-alicloud-modules/slb-listener/alicloud"
  region = var.region
  create = var.slb_listener_create
  slb    = alicloud_slb.idp-slb.id
  listeners = [
    {
      server_group_ids  = alicloud_slb_server_group.idp-vsg.id
      backend_port      = "80"
      frontend_port     = "80"
      protocol          = "http"
      bandwidth         = "-1"
      scheduler         = "wrr"
      healthy_threshold = "4"
      gzip              = "false"
      health_check_type = "http"
    },
    {
      server_group_ids      = alicloud_slb_server_group.idp-vsg.id
      backend_port          = "443"
      frontend_port         = "443"
      protocol              = "https"
      bandwidth             = "-1"
      scheduler             = "wrr"
      healthy_threshold     = "4"
      gzip                  = "false"
      health_check_type     = "http"
      server_certificate_id = alicloud_slb_server_certificate.slb_server_cert.id
    }
  ]

  // health_check will apply to all of listeners if health checking is not set in the listeners
  health_check = var.health_check

  // advanced_setting will apply to all of listeners if some fields are not set in the listeners
  advanced_setting = var.advanced_setting

  // x_forwarded_for will apply to all of listeners if it is not set in the listeners
  x_forwarded_for = var.x_forwarded_for
}

# EIP
resource "alicloud_eip_address" "eip_address_in" {
  address_name         = var.eip_address_in_name
  isp                  = "BGP"
  internet_charge_type = "PayByBandwidth"
  payment_type         = "PayAsYouGo"
  resource_group_id    = alicloud_resource_manager_resource_group.idp-rg.id
  tags                 = var.eip_address_tags
}


resource "alicloud_eip_address" "eip_address_out" {
  address_name         = var.eip_address_out_name
  isp                  = "BGP"
  internet_charge_type = "PayByBandwidth"
  payment_type         = "PayAsYouGo"
  resource_group_id    = alicloud_resource_manager_resource_group.idp-rg.id
  tags                 = var.eip_address_tags
}

resource "alicloud_eip_association" "eip_asso_in" {
  allocation_id = alicloud_eip_address.eip_address_in.id
  instance_id   = alicloud_slb.idp-slb.id
  instance_type = "SlbInstance"
}

resource "alicloud_eip_association" "eip_asso_out" {
  depends_on    = [alicloud_eip_address.eip_address_out]
  allocation_id = alicloud_eip_address.eip_address_out.id
  instance_id   = alicloud_nat_gateway.dev_nat_gateway.id
  instance_type = "Nat"
}

# NAT Gateway
resource "alicloud_nat_gateway" "dev_nat_gateway" {
  depends_on       = [module.vpc.this_vswitch_ids]
  vpc_id           = module.vpc.this_vpc_id
  nat_gateway_name = var.nat_gateway_name
  payment_type     = "PayAsYouGo"
  vswitch_id       = module.vpc.this_vswitch_ids.0
  nat_type         = "Enhanced"
  tags             = var.nat_gateway_tags
}

resource "alicloud_snat_entry" "snat" {
  depends_on        = [alicloud_eip_association.eip_asso_out]
  snat_table_id     = alicloud_nat_gateway.dev_nat_gateway.snat_table_ids
  source_vswitch_id = module.vpc.this_vswitch_ids.0
  snat_ip           = join(",", alicloud_eip_address.eip_address_out.*.ip_address)
}