
terraform {
  required_version = ">= 0.13"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
    ignition = {
      source  = "terraform-providers/ignition"
      version = "~> 1.2.0"
    }
    template = {
      source  = "hashicorp/template"
      version = "~> 2.1.0"
    }
  }
}


# Configure the OpenStack Provider
provider "openstack" {
  user_name   = var.openstack_username
  tenant_name = "E260-VERBIS-GBA"
  password    = var.openstack_password
  auth_url    = "https://cloud.dkfz-heidelberg.de:13000"
}

