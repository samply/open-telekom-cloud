terraform {
  backend "s3" {
    bucket                      = "gba-terraform"
    key                         = "otc"
    region                      = "eu-central-1"
    endpoint                    = "obs.eu-de.otc.t-systems.com"
    skip_credentials_validation = true
  }
}
