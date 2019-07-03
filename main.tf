module "network" {
  source   = "./modules/network"
  vpc_name = var.vpc_name
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
    "vpc-prod" = "80.158.32.82"
    "vpc-test" = "80.158.36.176"
  }
}

resource "opentelekomcloud_compute_floatingip_associate_v2" "server" {
  floating_ip = local.elastic_ips[var.vpc_name]
  instance_id = module.server.server.id
  fixed_ip    = module.server.server.network[0].fixed_ip_v4
}
