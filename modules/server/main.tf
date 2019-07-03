module "users" {
  source = "../users"
}

data "ignition_file" "hostname" {
  filesystem = "root"
  path       = "/etc/hostname"
  mode       = "0644"
  content {
    content = "server.openstacklocal"
  }
}

data "ignition_config" "server" {
  users = [
    module.users.martinbreu,
    module.users.akiel,
    module.users.bkroll,
    module.users.dolchchr,
    module.users.mlablans
  ]
  files = [
    data.ignition_file.hostname.id
  ]
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
