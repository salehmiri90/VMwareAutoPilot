output "vcenter_ip" {
  value       = var.vcenter_ip
  description = "vCenter IP address"
}

output "vcenter_fqdn" {
  value       = var.vcenter_fqdn
  description = "vCenter FQDN"
}

output "vcenter_user" {
  value       = "administrator@${var.vcenter_sso_domain}"
  description = "SSO user that was created during the vCenter provisioning"
}

output "vcenter_password" {
  value       = var.vcenter_sso_password
  description = "SSO user password that was set during the vCenter provisioning"
}

output "vcenter_root_user" {
  value       = "root"
  description = "Username for the local root user"
}

output "vcenter_root_password" {
  value       = var.vcenter_root_password
  description = "Password for the local root user"
}
