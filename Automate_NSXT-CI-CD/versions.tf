### versions

terraform {
  required_version = ">= 0.13"
  required_providers {
    nsxt = {
      source  = "registry.terraform.io/vmware/nsxt"
      version = "3.3.0"
    }
    vault = {
      source  = "registry.terraform.io/hashicorp/vault"
      version = "3.16.0"
    }
  }
}
