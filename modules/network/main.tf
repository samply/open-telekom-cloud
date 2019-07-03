resource "opentelekomcloud_vpc_v1" "vpc" {
  name = var.vpc_name
  cidr = "192.168.0.0/16"
}

resource "opentelekomcloud_dns_zone_v2" "default" {
  name = "openstacklocal."
  email = "notify@germanbiobanknode.de"
  description = "GBA-Zone"
  ttl = 3000
  type = "private"
  router {
    router_id = opentelekomcloud_vpc_v1.vpc.id
    router_region = "eu-de"
  }
}

resource "opentelekomcloud_vpc_subnet_v1" "default" {
  name = "default"
  cidr = "192.168.0.0/24"
  gateway_ip = "192.168.0.1"
  primary_dns = "100.125.4.25"
  secondary_dns = "100.125.129.199"
  vpc_id = opentelekomcloud_vpc_v1.vpc.id
}
