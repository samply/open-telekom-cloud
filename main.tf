module "network" {
  source   = "./modules/network"
}

module "postgres" {
  source    = "./modules/postgres"
  vpc       = module.network.vpc
  subnet    = module.network.subnet
  zone      = module.network.zone
  db_passwd = var.db_passwd
}

module "server" {
  source = "./modules/server"
  subnet = module.network.subnet
  zone   = module.network.zone
}

locals {
  elastic_ips = {
    "default" = "80.158.32.82"
    "test"    = "80.158.4.11"
  }
}

resource "opentelekomcloud_compute_floatingip_associate_v2" "server" {
  floating_ip = local.elastic_ips[terraform.workspace]
  instance_id = module.server.server.id
  fixed_ip    = module.server.server.network[0].fixed_ip_v4
}
