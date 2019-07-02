provider "opentelekomcloud" {
  access_key  = "FZFFMJO6LHDIZF1JLEUJ"
  secret_key  = var.secret_key
  domain_name = "OTC-EU-DE-00000000001000041103"
  tenant_name = "eu-de"
  auth_url    = "https://iam.eu-de.otc.t-systems.com/v3"
  version     = "~> 1.10"
}

provider "ignition" {
  version = "~> 1.1"
}

provider "template" {
  version = "~> 2.1"
}
