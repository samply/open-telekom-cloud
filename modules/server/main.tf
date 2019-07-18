module "users" {
  source = "../users"
}

module "haveged" {
  source        = "./haveged"
}

module "nginx" {
  source        = "./nginx"
  nginx_version = "1.17.1"
}

module "searchbroker" {
  source = "./searchbroker"
}

module "mdr" {
  source = "./mdr"
}

data "ignition_filesystem" "secrets" {
  name = "secrets"

  mount {
    device = "/dev/disk/by-label/SECRETS"
    format = "ext4"
    options = ["-L", "SECRETS"]
  }
}

data "ignition_directory" "secrets_mount_point_folder" {
  filesystem = "root"
  path       = "/mnt/secrets"
  mode       = "0700"
}

data "ignition_systemd_unit" "mnt_secrets_mount" {
  name    = "mnt-secrets.mount"
  content = file("${path.module}/mnt-secrets.mount")
}

data "ignition_filesystem" "ssl" {
  name = "ssl"

  mount {
    device = "/dev/disk/by-label/SSL"
    format = "ext4"
    options = ["-L", "SSL"]
  }
}

data "ignition_directory" "ssl_mount_point_folder" {
  filesystem = "root"
  path       = "/etc/nginx/ssl"
  mode       = "0700"
}

data "ignition_systemd_unit" "etc_nginx_ssl_mount" {
  name    = "etc-nginx-ssl.mount"
  content = file("${path.module}/etc-nginx-ssl.mount")
}

data "ignition_file" "hostname" {
  filesystem = "root"
  path       = "/etc/hostname"
  mode       = "420"
  content {
    content = "server.openstacklocal"
  }
}

data "ignition_config" "server" {
  systemd     = [
    data.ignition_systemd_unit.mnt_secrets_mount.id,
    data.ignition_systemd_unit.etc_nginx_ssl_mount.id,
    module.nginx.nginx_service,
    module.haveged.haveged_service,
    module.searchbroker.searchbroker_service,
    module.searchbroker.searchbroker_ui_service,
    module.mdr.mdr_service,
    module.mdr.mdr_ui_service
  ]
  users       = [
    module.users.core
  ]
  filesystems = [
    data.ignition_filesystem.ssl.id
  ]
  directories = [
    data.ignition_directory.secrets_mount_point_folder.id,
    data.ignition_directory.ssl_mount_point_folder.id
  ]
  files       = [
    data.ignition_file.hostname.id,
    module.nginx.searchbroker_config_file,
    module.nginx.auth_config_file,
    module.nginx.mdr_config_file
  ]
}

resource "opentelekomcloud_blockstorage_volume_v2" "ssl" {
  name = "ssl"
  size = 1
}

resource "opentelekomcloud_blockstorage_volume_v2" "secrets" {
  name = "secrets"
  size = 1
}

resource "opentelekomcloud_compute_instance_v2" "server" {
  name       = "server"
  image_name = "container-linux-2135.4.0-2"
  flavor_id  = "s2.medium.4"

  user_data = data.ignition_config.server.rendered

  security_groups = [
    "default"
  ]

  network {
    uuid = var.subnet
  }
}

resource "opentelekomcloud_compute_volume_attach_v2" "ssl_attach" {
  instance_id = opentelekomcloud_compute_instance_v2.server.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.ssl.id
}

resource "opentelekomcloud_compute_volume_attach_v2" "secrets_attach" {
  instance_id = opentelekomcloud_compute_instance_v2.server.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.secrets.id
}

resource "opentelekomcloud_dns_recordset_v2" "server" {
  zone_id     = var.zone
  name        = "server.openstacklocal."
  description = "Server"
  ttl         = 3000
  type        = "A"
  records     = [
    opentelekomcloud_compute_instance_v2.server.network[0].fixed_ip_v4
  ]
}
