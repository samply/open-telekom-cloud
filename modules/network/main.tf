resource "openstack_networking_network_v2" "default" {
  name = format("network-%s", terraform.workspace)
  cidr = "192.168.0.0/16"
}

resource "openstack_dns_zone_v2" "default" {
  name        = "openstacklocal."
  email       = "notify@germanbiobanknode.de"
  description = "GBA-Zone"
  ttl         = 3000
  type        = "private"
}

resource "openstack_networking_subnet_v2" "default" {
  network_id    = openstack_networking_network_v2.default.id
  cidr          = "192.168.0.0/24"
}
