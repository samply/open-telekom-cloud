module "users" {
  source = "../users"
}

module "haveged" {
  source = "./haveged"
}

module "init-network" {
  source = "./init-network"
}

module "nginx" {
  source        = "./nginx"
  nginx_version = "1.17.1"
}

module "certbot" {
  source          = "./certbot"
  certbot_version = "v0.36.0"
}

module "searchbroker" {
  source                  = "./searchbroker"
  searchbroker_version    = "8.4.1"
  searchbroker-ui_version = "2.1.0"
}

module "icd_dictionary" {
  source                  = "./icd-dictionary"
  icd_dictionary_version  = "0.3.1"
}

module "mdr" {
  source         = "./mdr"
  mdr_version    = "4.0.4-SNAPSHOT"
  mdr-ui_version = "2.0.6-SNAPSHOT"
}

data "ignition_disk" "data" {
  device  = "/dev/vdb"
  partition {
    label = "SECRETS"
    number = 1
    size = 1040000
  }
  partition {
    label = "SSL"
    number = 2
    size = 1040000
  }
}

data "ignition_filesystem" "secrets" {
  name = "secrets"
  mount {
    device  = "/dev/disk/by-partlabel/SECRETS"
    format  = "ext4"
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
    device  = "/dev/disk/by-partlabel/SSL"
    format  = "ext4"
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

data "ignition_file" "maintenance" {
  filesystem = "root"
  path       = "/etc/coreos/update.conf"
  mode       = "644"
  content {
    content = file("${path.module}/update.conf")
  }
}

data "ignition_file" "docker_daemon" {
  filesystem = "root"
  path       = "/etc/docker/daemon.json"
  mode       = "644"
  content {
    content = file("${path.module}/daemon.json")
  }
}

data "ignition_config" "server" {
  systemd     = [
    data.ignition_systemd_unit.mnt_secrets_mount.rendered,
    data.ignition_systemd_unit.etc_nginx_ssl_mount.rendered,
    module.nginx.nginx_service,
    module.haveged.haveged_service,
    module.searchbroker.searchbroker_service,
    module.searchbroker.searchbroker_ui_service,
    module.icd_dictionary.icd_dictionary_service,
    module.mdr.mdr_service,
    module.mdr.mdr_ui_service,
    module.certbot.certbot_service,
    module.certbot.certbot_timer,
    module.init-network.init-network_service
  ]
  users       = [
    module.users.core
  ]
  disks = [
    data.ignition_disk.data.rendered
  ]
  filesystems = [
    data.ignition_filesystem.secrets.rendered,
    data.ignition_filesystem.ssl.rendered
  ]
  directories = [
    data.ignition_directory.secrets_mount_point_folder.rendered,
    data.ignition_directory.ssl_mount_point_folder.rendered,
    module.nginx.etc_nginx_dir
  ]
  files       = [
    data.ignition_file.hostname.rendered,
    module.nginx.nginx_config_file,
    module.nginx.searchbroker_config_file,
    module.nginx.mdr_config_file,
    module.nginx.acme-challenge_global_file,
    data.ignition_file.maintenance.rendered,
    data.ignition_file.docker_daemon.rendered
  ]
}

resource "opentelekomcloud_blockstorage_volume_v2" "data" {
  name = format("server-data-%s", terraform.workspace)
  size = 10
}

resource "opentelekomcloud_compute_instance_v2" "server" {
  name            = format("server-%s", terraform.workspace)
  image_name      = "container-linux-2303.4.0"
  flavor_id       = terraform.workspace == "default" ? "s2.large.4" : "s2.medium.4"
  user_data       = data.ignition_config.server.rendered
  security_groups = [
    "default"
  ]
  network {
    uuid = var.subnet
  }
}

resource "opentelekomcloud_compute_volume_attach_v2" "data_attach" {
  instance_id = opentelekomcloud_compute_instance_v2.server.id
  volume_id   = opentelekomcloud_blockstorage_volume_v2.data.id
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
