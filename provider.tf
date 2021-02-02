# Configure the OpenStack Provider
provider "openstack" {
  user_name   = var.openstack_username
  tenant_name = "E260-VERBIS-GBA"
  password    = var.openstack_password
  auth_url    = "https://cloud.dkfz-heidelberg.de:13000"
}

provider "ignition" {
  version = "~> 1.1"
}

provider "template" {
  version = "~> 2.1"
}
