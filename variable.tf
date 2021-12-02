variable "environment_prefix" {
  description = "Prefix that represents the environment that precedes each resource"
  type        = string
  default     = "dev"
}

variable "profile" {
  description = "The password of instance."
  type        = string
  default     = ""
}

// プロバイダー
variable "region" {
  description = "(Deprecated from version 1.9.0) The region used to launch this module resources."
  type        = string
  default     = "ap-northeast-1"
}

// リソースグループ
variable "resource_group_name_idp" {
  description = "The Name of resource group which the instance belongs."
  type        = string
  default     = "idp-rg"
}

variable "resource_group_name_maintenance" {
  description = "The Name of resource group which the instance belongs."
  type        = string
  default     = "maintenance-rg"
}

variable "resource_group_display_name_idp" {
  description = "The Name of resource group which the instance belongs."
  type        = string
  default     = "idp-rg"
}

variable "resource_group_display_name_maintenance" {
  description = "The Name of resource group which the instance belongs."
  type        = string
  default     = "maintenance-rg"
}

// キーペア
variable "key_name" {
  description = "The name of key pair."
  type        = string
  default     = "keyPair"
}

variable "key_pair_tags" {
  description = "The password of instance."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}

//vpcモジュール
variable "availability_zones" {
  description = "List available zones to launch several VSwitches."
  type        = list(string)
  default     = ["ap-northeast-1a", "ap-northeast-1b"]
}

variable "vpc_create" {
  description = "Whether to create vpc. If false, you can specify an existing vpc by setting 'vpc_id'."
  type        = bool
  default     = true
}

variable "destination_cidrs" {
  description = "List of destination CIDR block of virtual router in the specified VPC."
  type        = list(string)
  default     = []
}

variable "nexthop_ids" {
  description = "List of next hop instance IDs of virtual router in the specified VPC."
  type        = list(string)
  default     = []
}

variable "vswitch_use_num_suffix" {
  description = "Always append numerical suffix(like 001, 002 and so on) to vswitch name, even if the length of `vswitch_cidrs` is 1"
  type        = bool
  default     = false
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  type        = string
  default     = "172.16.0.0/12"
}

variable "vpc_description" {
  description = "The vpc description used to launch a new vpc."
  type        = string
  default     = "A new VPC created by Terrafrom module terraform-alicloud-vpc"
}

variable "vpc_id" {
  description = "The vpc id used to launch several vswitches. If set, the 'create' will be ignored."
  type        = string
  default     = ""
}

variable "vpc_name" {
  description = "The vpc name used to launch a new vpc."
  type        = string
  default     = "vpc"
}

variable "vpc_tags" {
  description = "The tags used to launch a new vpc. Before 1.5.0, it used to retrieve existing VPC."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}

variable "vswitch_cidrs" {
  description = "List of cidr blocks used to launch several new vswitches. If not set, there is no new vswitches will be created."
  type        = list(string)
  default     = ["172.16.0.0/24", "172.17.0.0/24"]
}

variable "vswitch_description" {
  description = "The vswitch description used to launch several new vswitch."
  type        = string
  default     = "New VSwitch created by Terrafrom module terraform-alicloud-vpc."
}

variable "vswitch_name" {
  description = "The vswitch name prefix used to launch several new vswitches."
  type        = string
  default     = "vswitch"
}

variable "vswitch_tags" {
  description = "The tags used to launch serveral vswitches."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}

variable "security_group_name" {
  description = "Name of security group. It is used to create a new security group."
  type        = string
  default     = "sg"
}

variable "security_group_type" {
  description = "The type of the security group. Valid values: 'normal'(basic security group.), 'enterprise'(advanced security group For more information.). Default to 'normal'."
  type        = string
  default     = "normal"
}

variable "ip_protocol" {
  description = "A priority is used when setting `ingress_rules`. Default to `default_ingress_priority`."
  type        = string
  default     = "tcp"
}

variable "nic_type" {
  description = "A priority is used when setting `ingress_rules`. Default to `default_ingress_priority`."
  type        = string
  default     = "intranet"
}

variable "sevurity_grouop_policy" {
  description = "A priority is used when setting `ingress_rules`. Default to `default_ingress_priority`."
  type        = string
  default     = "accept"
}

variable "security_group_port_range" {
  description = "A priority is used when setting `ingress_rules`. Default to `default_ingress_priority`."
  type        = string
  default     = "1/65535"
}

variable "security_group_description" {
  description = "Description of security group"
  type        = string
  default     = "Security group for user-service with custom ports open within VPC"
}

variable "priority_for_ingress_rules" {
  description = "A priority is used when setting `ingress_rules`. Default to `default_ingress_priority`."
  type        = number
  default     = 1
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))
  default     = {}
}

variable "default_ingress_priority" {
  description = "A default ingress priority."
  type        = number
  default     = 50
}

variable "ingress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on ingress cidrs rules."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name"
  type        = list(string)
  default     = ["https-443-tcp"]
}

variable "ingress_ports" {
  description = "The port list used on `ingress_with_cidr_blocks_and_ports` ports rules."
  type        = list(number)
  default     = []
}

variable "ingress_with_cidr_blocks_and_ports" {
  description = "List of ingress rules to create where `cidr_blocks` and `ports` is used."
  type        = list(map(string))
  default = [
    {
      ports       = "80"
      protocol    = "tcp"
      priority    = 50
      cidr_blocks = "0.0.0.0/0"
    },
    {
      ports       = "22"
      protocol    = "tcp"
      priority    = 50
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used."
  type        = list(map(string))
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where `source_security_group_id` is used."
  type        = list(map(string))
  default     = []
}

variable "priority_for_egress_rules" {
  description = "A priority where `egress_rules` is used."
  type        = number
  default     = 1
}

variable "egress_ports" {
  description = "The port list used on `egress_with_cidr_blocks_and_ports` ports rules."
  type        = list(number)
  default     = []
}

variable "egress_rules" {
  description = "List of egress rules to create by name"
  type        = list(string)
  default     = []
}

variable "egress_with_cidr_blocks" {
  description = "List of egress rules to create where 'cidr_blocks' is used."
  type        = list(map(string))
  default     = []
}

variable "egress_with_cidr_blocks_and_ports" {
  description = "List of egress rules to create where `cidr_blocks` and `ports` is used."
  type        = list(map(string))
  default     = []
}

variable "egress_with_source_security_group_id" {
  description = "List of egress rules to create where 'source_security_group_id' is used"
  type        = list(map(string))
  default     = []
}

variable "existing_group_id" {
  description = "ID of existing security group. If set, the `create` will be ignored."
  type        = string
  default     = ""
}

variable "default_egress_priority" {
  description = "A default egress priority."
  type        = number
  default     = 50
}

variable "security_group_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "learn"
  }
}

variable "egress_cidr_blocks" {
  description = "The IPv4 CIDR ranges list to use on egress cidrs rules."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {}
}

// ECSインスタンス
variable "instance_name" {
  description = "(Deprecated) It has been deprecated from version 2.0.0 and use 'name' instead."
  type        = string
  default     = "idp_ecs"
}

variable "instance_type" {
  description = "The instance type used to launch one or more ecs instances."
  type        = string
  default     = "ecs.g6.large"
}

variable "image_id" {
  description = "The image id used to launch one or more ecs instances."
  type        = string
  default     = "aliyun_2_1903_x64_20G_qboot_alibase_20210726.vhd"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public ip address with an instance in a VPC."
  type        = bool
  default     = false
}

variable "credit_specification" {
  description = "Performance mode of the t5 burstable instance."
  type        = string
  default     = ""
}

variable "data_disks" {
  description = "Additional data disks to attach to the scaled ECS instance."
  type        = list(map(string))
  default     = []
}

variable "deletion_protection" {
  description = "Whether enable the deletion protection or not. 'true': Enable deletion protection."
  type        = bool
  default     = false
}

variable "instance_description" {
  description = "Description of all instances."
  type        = string
  default     = "New instance created by Terrafrom module terraform-alicloud-ecs-cluster."
}

variable "dry_run" {
  description = "Whether to pre-detection. When it is true, only pre-detection and not actually modify the payment type operation."
  type        = bool
  default     = false
}

variable "force_delete" {
  description = "If it is true, the 'PrePaid' instance will be change to 'PostPaid' and then deleted forcibly."
  type        = bool
  default     = false
}

variable "host_name" {
  description = "Host name used on all instances as prefix. Like if the value is TF-ECS-Host-Name and then the final host name would be TF-ECS-Host-Name001, TF-ECS-Host-Name002 and so on."
  type        = string
  default     = "idp_server"
}

variable "internet_max_bandwidth_out" {
  description = "The maximum internet out bandwidth of instance."
  type        = number
  default     = 10
}

variable "instance_charge_type" {
  description = "The charge type of instance."
  type        = string
  default     = ""
}

variable "ecs_internet_charge_type" {
  description = "The internet charge type of instance."
  type        = string
  default     = "PayByTraffic"
}

variable "kms_encrypted_password" {
  description = "An KMS encrypts password used to an instance."
  type        = string
  default     = ""
}

variable "kms_encryption_context" {
  description = "An KMS encryption context used to decrypt 'kms_encrypted_password' before creating or updating an instance with 'kms_encrypted_password'."
  type        = map(string)
  default     = {}
}

variable "number_of_instances" {
  description = "The number of instances to be created."
  type        = number
  default     = 1
}

variable "instance_password" {
  description = "The password of instance."
  type        = string
  default     = "" // 半角小文字・半角大文字・記号の3種類を含めた6文字にする
}

variable "system_disk_category" {
  description = " The system disk category used to launch one or more ecs instances."
  type        = string
  default     = "cloud_ssd"
}

variable "system_disk_size" {
  description = "The system disk size used to launch one or more ecs instances."
  type        = number
  default     = 40
}

variable "private_ip" {
  description = "Configure Instance private IP address."
  type        = string
  default     = ""
}

variable "ecs_instances_private_ips" {
  description = "A list to configure Instance private IP address"
  type        = list(string)
  default     = ["172.16.0.10", "172.17.0.10"]
}

variable "role_name" {
  description = "Instance RAM role name."
  type        = string
  default     = ""
}

variable "security_enhancement_strategy" {
  description = "The security enhancement strategy."
  type        = string
  default     = ""
}

variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID."
  type        = bool
  default     = false
}

variable "spot_price_limit" {
  description = "The hourly price threshold of a instance, and it takes effect only when parameter 'spot_strategy' is 'SpotWithPriceLimit'."
  type        = number
  default     = 0
}

variable "spot_strategy" {
  description = "The spot strategy of a Pay-As-You-Go instance, and it takes effect only when parameter 'instance_charge_type' is 'PostPaid'."
  type        = string
  default     = ""
}

variable "subscription" {
  description = "The hourly price threshold of a instance, and it takes effect only when parameter 'spot_strategy' is 'SpotWithPriceLimit'."
  type        = map(string)
  default     = {}
}

variable "system_disk_auto_snapshot_policy_id" {
  description = "The ID of the automatic snapshot policy applied to the system disk."
  type        = string
  default     = ""
}

variable "instance_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}

variable "instance_use_num_suffix" {
  description = "Always append numerical suffix(like 001, 002 and so on) to instance name and host name, even if number_of_instances is 1."
  type        = bool
  default     = false
}

variable "volume_tags" {
  description = "A mapping of tags to assign to the devices created by the instance at launch time."
  type        = map(string)
  default     = {}
}

// ロードバランサー
variable "slb_create" {
  description = "Whether to create load balancer instance. If setting 'use_existing_slb = true' and 'existing_slb_id', it will be ignored."
  type        = bool
  default     = true
}

variable "existing_slb_id" {
  description = "An existing load balancer instance id."
  type        = string
  default     = ""
}

variable "use_existing_slb" {
  description = "Whether to use an existing load balancer instance. If true, 'existing_slb_id' should not be empty. Also, you can create a new one by setting 'create = true'."
  type        = bool
  default     = false
}

variable "slb_internet_charge_type" {
  description = "The charge type of load balancer instance internet network."
  type        = string
  default     = "PayByTraffic"
}

variable "slb_name" {
  description = "The name of a new load balancer."
  type        = string
  default     = "slb"
}

variable "bandwidth" {
  description = "The load balancer instance bandwidth."
  type        = number
  default     = 10
}

variable "address_type" {
  description = "The type of address. Choices are 'intranet' and 'internet'. Default to 'internet'."
  type        = string
  default     = "intranet"
}

variable "servers_of_default_server_group" {
  description = "A list of attached ECS instances, it's supports fields 'server_ids', 'weight'(default to 100), and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
}

variable "servers_of_master_slave_server_group" {
  description = "A list of servers attaching to master-slave server group, it's supports fields 'server_ids', 'weight'(default to 100), 'port', 'server_type' and 'type'(default to 'ecs')."
  type        = list(map(string))
  default     = []
}

variable "master_slave_server_group_name" {
  description = "The name master slave server group. If not set, the 'name' and adding suffix '-master-slave' will return."
  type        = string
  default     = ""
}

variable "virtual_server_group_name" {
  description = "The name virtual server group. If not set, the 'name' and adding suffix '-virtual' will return."
  type        = string
  default     = "v_server_group"
}

variable "slb_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}

variable "master_zone_id" {
  description = "The primary zone ID of the SLB instance. If not specified, the system will be randomly assigned."
  type        = string
  default     = ""
}

variable "slave_zone_id" {
  description = "The standby zone ID of the SLB instance. If not specified, the system will be randomly assigned."
  type        = string
  default     = ""
}

variable "slb_spec" {
  description = "The specification of the SLB instance."
  type        = string
  default     = "slb.s1.small"
}

// ロードバランサーリスナー
variable "slb_listener_create" {
  description = "Whether to create load balancer listeners."
  type        = bool
  default     = true
}

variable "health_check" {
  description = "The slb listener health check settings to use on listeners."
  type        = map(string)
  default = {
    health_check              = "on"
    health_check_type         = "tcp"
    healthy_threshold         = "3"
    unhealthy_threshold       = "2"
    health_check_timeout      = "5"
    health_check_interval     = "2"
    health_check_connect_port = "80"
    health_check_uri          = "/index.html"
    health_check_http_code    = "http_2xx"
  }
}

variable "advanced_setting" {
  description = "The slb listener advanced settings to use on listeners."
  type        = map(string)
  default = {
    sticky_session      = "on"
    sticky_session_type = "insert"
    cookie_timeout      = "10000"
    gzip                = "false"
    retrive_slb_ip      = "true"
    retrive_slb_id      = "false"
    retrive_slb_proto   = "true"
    persistence_timeout = "5"
  }
}

variable "x_forwarded_for" {
  description = "Additional HTTP Header field 'X-Forwarded-For' to use on listeners."
  type        = map(string)
  default = {
    retrive_slb_ip    = "true"
    retrive_slb_id    = "false"
    retrive_slb_proto = "true"
  }
}

variable "ssl_certificates" {
  description = "SLB Server certificate settings to use on listeners."
  type        = map(string)
  default = {
    tls_cipher_policy = "tls_cipher_policy_1_0"
  }
}

// ログ
variable "log_create" {
  description = "Whether to create log resources"
  type        = bool
  default     = true
}

variable "project_name" {
  description = "Log project name. If not set, a default name with prefix `sls-module-project-` will be returned."
  type        = string
  default     = "log-project"
}

variable "system_store_name" {
  description = "System log store name."
  type        = string
  default     = "log_store_system"
}

variable "auth_store_name" {
  description = "Authnection log store name."
  type        = string
  default     = "log_store_authn"
}

variable "store_retention_period" {
  description = "The data retention time (in days)."
  type        = number
  default     = 30
}

variable "store_shard_count" {
  description = "The number of shards in this log store."
  type        = number
  default     = 2
}

variable "store_auto_split" {
  description = "Determines whether to automatically split a shard."
  type        = bool
  default     = true
}

variable "store_max_split_shard_count" {
  description = "The maximum number of shards for automatic split, which is in the range of 1 to 64."
  type        = number
  default     = 1
}

variable "store_append_meta" {
  description = "Determines whether to append log meta automatically."
  type        = bool
  default     = true
}

variable "store_enable_web_tracking" {
  description = "Determines whether to enable Web Tracking."
  type        = bool
  default     = false
}

variable "index_full_text" {
  description = "The configuration of full text index."
  type        = set(map(string))
  default = [
    {
      case_sensitive  = false
      include_chinese = false
      token           = "#"
    }
  ]
}

variable "index_field_search" {
  description = "List configurations of field search index."
  type = set(object({
    name             = string
    type             = string
    alias            = string
    case_sensitive   = bool
    include_chinese  = bool
    token            = string
    enable_analytics = bool
    doc_value        = bool
    json_keys = list(object({
      name      = string
      type      = string
      alias     = string
      doc_value = bool
    }))
  }))
  default = [
    {
      name             = "basic"
      type             = "long"
      alias            = "basic1"
      case_sensitive   = true
      include_chinese  = true
      token            = "#"
      enable_analytics = "true"
      doc_value        = true
      json_keys = [
        {
          name      = "basic_json_key"
          type      = "long"
          alias     = "basic_json_key1"
          doc_value = true
        }
      ]
    }
  ]
}

variable "use_random_suffix" {
  description = "Whether to add a suffix for project name."
  type        = bool
  default     = true
}

variable "kvstore_instance_name" {
  default = "redis-instance"
}

variable "kvstore_account_name" {
  default = "redisuser"
}

variable "kvstore_account_password" {
  default = ""
}

variable "eip_address_in_name" {
  default = "eip-address-in"
}

variable "eip_address_out_name" {
  default = "eip-address-out"
}

variable "nat_gateway_name" {
  default = "nat-gateway"
}

variable "slb_server_cert_name" {
  default = "slb-server-cert"
}

variable "slb_server_cert_certificate" {
}

variable "slb_server_cert_privatekey" {
}

variable "container_group_name" {
  default = "eci-container-group"
}

variable "container_group_cpu" {
  default = "0.25"
}

variable "container_group_memory" {
  default = "0.5"
}

variable "container_image" {
  default = "registry-vpc.ap-northeast-1.aliyuncs.com/eci_open/httpd"
}

variable "container_name" {
  default = "idp-container"
}

variable "nat_gateway_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}

variable "eip_address_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}

variable "kvstore_instance_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default = {
    Created     = "Terraform"
    Environment = "development"
  }
}
