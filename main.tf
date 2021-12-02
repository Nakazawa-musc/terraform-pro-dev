// プロバイダー
terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "1.141.0"
    }
  }
}
provider "alicloud" {
  # access_key = var.access_key // PCの環境変数ALICLOUD_ACCESS_KEYを設定している場合は不要
  # secret_key = var.secret_key // PCの環境変数ALICLOUD_SECRET_KEYを設定している場合は不要
  # region     = var.region // PCの環境変数ALICLOUD_REGIONを設定している場合は不要
}

// SSHアクセスキーペア
resource "alicloud_key_pair" "key_pair" {
  key_pair_name     = var.key_name
  public_key        = var.key_pair
  resource_group_id = alicloud_resource_manager_resource_group.idp-rg.id
  tags              = var.key_pair_tags
}

// リソースグループ
resource "alicloud_resource_manager_resource_group" "idp-rg" {
  resource_group_name = var.resource_group_name_idp
  display_name        = var.resource_group_display_name_idp
}

// ECSインスタンス
module "ecs_cluster" {
  source  = "alibaba/ecs-instance/alicloud"
  version = "~> 2.7"

  number_of_instances = 2
  resource_group_id   = alicloud_resource_manager_resource_group.idp-rg.id
  vswitch_ids         = module.vpc.this_vswitch_ids
  security_group_ids  = [alicloud_security_group.idp-sg.id]

  internet_charge_type        = var.ecs_internet_charge_type
  name                        = var.instance_name
  instance_type               = var.instance_type
  image_id                    = var.image_id
  private_ips                 = var.ecs_instances_private_ips
  associate_public_ip_address = var.associate_public_ip_address
  data_disks                  = var.data_disks
  deletion_protection         = var.deletion_protection
  description                 = var.instance_description
  host_name                   = var.host_name
  internet_max_bandwidth_out  = var.internet_max_bandwidth_out
  key_name                    = alicloud_key_pair.key_pair.key_name
  password                    = var.instance_password
  system_disk_category        = var.system_disk_category
  system_disk_size            = var.system_disk_size
  tags                        = var.tags
  use_num_suffix              = var.instance_use_num_suffix

  // 下記2点により、直書きしている。可視性が高い別の記述方法があるか検討したい。
  // variable.tfでの変数定義の使用では、projectNameとlogstoreNameの変数が使用できない
  // provisioning.shファイルからの呼び出しでは、projectとlogstoreが空に設定されてしまう。
  user_data = <<EOF
#!/bin/sh
wget http://logtail-release-ap-northeast-1.oss-ap-northeast-1-internal.aliyuncs.com/linux64/logtail.sh -O logtail.sh; chmod 755 logtail.sh; ./logtail.sh install ap-northeast-1
yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum -y install --enablerepo=remi,remi-php73 php php-devel php-mbstring php-pdo php-mysql php-gd php-xml php-mcrypt
sed -i -e "s/short_open_tag = Off/short_open_tag = On/g" /etc/php.ini
yum install -y httpd
systemctl start httpd
cd /var/www/html
touch index.html
echo helloaooaoaoaoaoa > index.html
yum install -y git
git clone https://github.com/aliyun/aliyun-log-php-sdk.git
cd aliyun-log-php-sdk/sample
sed -i -e "s/\$endpoint = '';/\$endpoint = 'ap-northeast-1-intranet.log.aliyuncs.com';/g" loggerSample.php
sed -i -e "s/\$accessKeyId = '';/\$accessKeyId = 'LTAI5t82smVmbuE8ohHFC8Po';/g" loggerSample.php
sed -i -e "s/\$accessKey = '';/\$accessKey = 'LcepBDB7s67bHGQFUo7S6sWOxHhQqM';/g" loggerSample.php
sed -i -e "s/\$project = '';/\$project = `${concat(alicloud_log_project.this.*.name, [""])[0]}`;/g" loggerSample.php
sed -i -e "s/\$logstore = '';/\$logstore = `${concat(alicloud_log_store.authn.*.name, [""])[0]}`;/g" loggerSample.php
sed -i -e '18i phpinfo();' loggerSample.php
EOF
}
