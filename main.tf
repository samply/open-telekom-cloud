module "network" {
  source   = "./modules/network"
}

#module "postgres" {
#  source    = "./modules/postgres"
#  vpc       = module.network.vpc
#  subnet    = module.network.subnet
#  zone      = module.network.zone
#  db_passwd = var.db_passwd
#}

module "server" {
  source = "./modules/server"
  subnet = module.network.subnet
  zone   = module.network.zone
}

locals {
  floating_ips = {
    "prod"    = "10.128.129.90"
    "test"    = "10.128.129.178"
  }
}

resource "openstack_compute_floatingip_associate_v2" "server" {
  floating_ip = local.floating_ips[terraform.workspace]
  instance_id = module.server.server.id
  fixed_ip    = module.server.server.network[0].fixed_ip_v4
}
