provider "openstack" {
  application_credential_id     = "ebca0e8162b641beb2636cecab4c2fc1"
  auth_url                      = "https://prod1.api.pco.get-cloud.io:5000"
  region                        = "prod1"
  domain_name                   = "pco"
  application_credential_secret = "A7krq9Atc3sm2Po2aL9Fu3AMzdNwpF"
  use_octavia                   = true

}

