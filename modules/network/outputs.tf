output "vpc" {
  value = openstack_vpc_v1.vpc.id
}

output "subnet" {
  value = openstack_vpc_subnet_v1.default.id
}

output "zone" {
  value = openstack_dns_zone_v2.default.id
}
