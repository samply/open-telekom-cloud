output "vpc" {
  value = opentelekomcloud_vpc_v1.vpc.id
}

output "subnet" {
  value = opentelekomcloud_vpc_subnet_v1.default.id
}

output "zone" {
  value = opentelekomcloud_dns_zone_v2.default.id
}
