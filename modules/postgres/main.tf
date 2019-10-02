data "opentelekomcloud_networking_secgroup_v2" "default" {
  name = "default"
}

resource "opentelekomcloud_rds_instance_v3" "postgres" {
  availability_zone = [
    "eu-de-01"
  ]
  db {
    password = var.db_passwd
    type     = "PostgreSQL"
    version  = "9.6"
  }
  name              = terraform.workspace == "default" ? "postgres" : format("postgres-%s", terraform.workspace)
  security_group_id = data.opentelekomcloud_networking_secgroup_v2.default.id
  subnet_id         = var.subnet
  vpc_id            = var.vpc
  volume {
    type = "COMMON"
    size = 40
  }
  flavor = "rds.pg.c2.medium"
  backup_strategy {
    start_time = "08:00-09:00"
    keep_days  = 3
  }
}

resource "opentelekomcloud_dns_recordset_v2" "postgres" {
  zone_id     = var.zone
  name        = "postgres.openstacklocal."
  description = "Postgres"
  ttl         = 3000
  type        = "A"
  records     = opentelekomcloud_rds_instance_v3.postgres.private_ips
}

