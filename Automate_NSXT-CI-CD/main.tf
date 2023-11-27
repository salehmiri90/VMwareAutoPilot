### providers

provider "nsxt" {
  host                 = data.vault_generic_secret.nsxt.data["host"]
  username             = data.vault_generic_secret.nsxt.data["username"]
  password             = data.vault_generic_secret.nsxt.data["password"]
  allow_unverified_ssl = true
  max_retries          = 2
}

provider "vault" {

  address         = "https://vault01.saleh.miri:8200/"
  skip_tls_verify = true
  token           = var.vault_token
}

data "vault_generic_secret" "nsxt" {
  path = "nsxt/nsxt"
}

resource "nsxt_policy_group" "saleh-miri" {
  display_name = "saleh-miri"

  criteria {
    ipaddress_expression {
      ip_addresses = var.access_ip
    }
  }
}
