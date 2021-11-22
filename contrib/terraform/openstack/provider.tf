provider "openstack" {
  # TODO: Set!
  application_credential_id     = ""
  auth_url                      = "https://prod1.api.pco.get-cloud.io:5000"
  region                        = "prod1"
  domain_name                   = "pco"
  # TODO: Set!
  application_credential_secret = ""
  use_octavia                   = true
}

