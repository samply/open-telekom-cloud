data "ignition_user" "martinbreu" {
  name                = "martinbreu"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSp5/SBuVmer4jNfj5ztYsZyqe4uIK/BiEVbejC5fqbPadjVu2WW2l53aq586BfCLUtWGezWZSQekzz5zJNUxsCUqiCBY32GnESbh/MOfBNnx1Xwg6FeuVqzP91QgOWV9nzeVioO0Setg705FPoImlA0nwU6pS57QE3ll34R9Oky6xHV+wvVAj5K2YmDttsj/SOowo/kuwg2U9wS0qNQhX7FQjUk6kpeGoQ354NmmwCDaJtU9IUTY8BdXaM80USMc5V6huBYFnwoZXAkpKhTNo0ucFkXrrDaagghUK4FjoftG/EpDuQRVi3Hrgx3EHp89uBU1xOylgs9wR485gIm56nrErD2gr5i+rfRL4KTFoBekefQU2zIAKbZkSdFx7SdzdBPyWRszLFJCpVkfngsY3DLx9Lu6Vnt9vJNYXe06M/fqxBVEwP8esMJDZTZybp0cqAfUXUCAyKAxpgvlGJSz+pBJXtu5wOd6feK5ySJf52219QLXXfjlQxlYb13oEnxuESehTVHIqFpI88OTnU9LgF8mkcRudhVXoPw1k/9Sg34NZp4kB18p7rUezIplIMI1hRLYgmeqovRMSeV0Sb3n63iBSutHu1RMFG6VkBN59aVCx8+lg2SgLp2NcX4frgjNuVZBFko3ksniXosvhdTsoCcPW3R3rjMhKGfdoGaWbhQ== martinbreu"
  ]
}

data "ignition_user" "akiel" {
  name                = "akiel"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXNWbPLgh2qbRY5h20MzK6ezuYqYFNW1uDbkXehsX0/9eWY8+W0lh/LN6qOhx0/SDhZS1m2HM1HXpK9rbgkx0CejW+Di6sAOE52/6r9d4q4LshxjSjQvn0YAulu7ErwAoTJgFcOcUf8GXMU0FbSUgSBiwjD/TUHw30ywWmDqWtR2YzZH5qYZMlDaoh3RXxZGbNc1t3YOpIAUXutJUzHn4ekG4OltF8Wc2uHfr+Q0jAwi4zthhNMnZ8cgLHze1AMRV/QvzPG/h6TQ+A2vhMSo9lCV0eRH/dg6dADSHNoQxFHB/7Z7VHXZZoOhD4L8W8P7rWnbeVevYw9enZECxdCqLR akiel"
  ]
}

data "ignition_user" "bkroll" {
  name                = "bkroll"
  groups              = [
    "wheel",
    "docker"
  ]
  ssh_authorized_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAwp4MKHmgq49N7QNUfXRZZ/hhs0co5kSs7QhHl7HfOLoRsi+cChS4BRWJm8EoGN8tvrkJvky7ke2tbrJNW++jIzlgfO/4zs4imo0ornWvMAWmS6iDl0j0hjJc18WVurQgYgQiCmylJdh+41e4ToqYpl2Qyy0lBtrvbE+RpoyQxx0fMJ9i5nei5T50E97diYHxq4ijw1BxKyRircZbvu0m0mUDs242yW2i7eIVafPQgP6BBjravXRSzuRblaReG63CESZfebCZHNH3NJ09+/6mkO6nZcjXxPpq1S95r88Sj3XWJK1EjMT2r+NKlFBYJfERZK6JTLz247tmn9AeDxAwFw== bkroll"
  ]
}

resource "opentelekomcloud_vpc_v1" "vpc" {
  name = var.vpc_name
  cidr = "192.168.0.0/16"
}

resource "opentelekomcloud_vpc_subnet_v1" "default" {
  name = "default"
  cidr = "192.168.0.0/24"
  gateway_ip = "192.168.0.1"
  primary_dns = "100.125.4.25"
  secondary_dns = "8.8.8.8"
  vpc_id = opentelekomcloud_vpc_v1.vpc.id
}

data "opentelekomcloud_networking_secgroup_v2" "default" {
  name = "default"
}

resource "opentelekomcloud_rds_instance_v3" "database" {
  availability_zone = ["eu-de-01"]
  db {
    password = var.db_passwd
    type = "PostgreSQL"
    version = "9.6"
  }
  name = "database"

  security_group_id = data.opentelekomcloud_networking_secgroup_v2.default.id
  subnet_id = opentelekomcloud_vpc_subnet_v1.default.id
  vpc_id = opentelekomcloud_vpc_v1.vpc.id

  volume {
    type = "COMMON"
    size = 40
  }

  flavor = "rds.pg.c2.medium"

  backup_strategy {
    start_time = "08:00-09:00"
    keep_days = 3
  }
}

data "ignition_config" "server" {
  users   = [
    data.ignition_user.martinbreu.id,
    data.ignition_user.akiel.id,
    data.ignition_user.bkroll.id
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
    uuid = opentelekomcloud_vpc_subnet_v1.default.id
  }
}

resource "opentelekomcloud_networking_floatingip_v2" "server" {
  pool = "admin_external_net"
}

resource "opentelekomcloud_compute_floatingip_associate_v2" "server" {
  floating_ip = opentelekomcloud_networking_floatingip_v2.server.address
  instance_id = opentelekomcloud_compute_instance_v2.server.id
  fixed_ip    = opentelekomcloud_compute_instance_v2.server.network[0].fixed_ip_v4
}
