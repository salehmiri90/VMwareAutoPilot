locals {
  binaries_path = var.binaries_path
  vcsa_template = templatefile("/root/saleh/vcsa-${var.deploy_type}.json.tmpl", {
    esxi_hostname         = var.esxi_hostname
    esxi_username         = var.esxi_username
    esxi_password         = var.esxi_password

    vc_hostname           = var.vc_hostname
    vc_username           = var.vc_username
    vc_password           = var.vc_password
    vc_datacenter         = var.vc_datacenter
    vc_cluster            = var.vc_cluster

    vcenter_hostname      = var.vcenter_vmname
    vcenter_root_password = var.vcenter_root_password
    vcsa_datastore        = var.vcsa_datastore
    vcsa_network          = var.vcsa_network
    disk_mode             = var.disk_mode
    deployment_size       = var.deployment_size
    ip_family             = var.ip_family
    network_mode          = var.network_mode

    vcenter_fqdn          = var.vcenter_fqdn
    vcenter_ip            = var.vcenter_ip
    vcenter_prefix        = var.vcenter_prefix
    vcenter_gateway       = var.vcenter_gateway
    vcenter_dns           = var.vcenter_dns
    vcenter_ntp_server    = var.vcenter_ntp_server

    vcenter_ssh_enabled   = var.vcenter_ssh_enabled
    vcenter_sso_password  = var.vcenter_sso_password
    vcenter_sso_domain    = var.vcenter_sso_domain
    vcenter_ceip_status   = var.vcenter_ceip_status
  })
}

resource "local_file" "vcsa_template_to_json" {
  filename = "/tmp/vcsa-${var.deploy_type}.json"
  content  = local.vcsa_template
}

resource "null_resource" "vcsa_linux_deploy" {
  count = var.windows == false ? 1 : 0
  provisioner "local-exec" {
    command = "${local.binaries_path}/vcsa-cli-installer/lin64/vcsa-deploy install --accept-eula --acknowledge-ceip --no-ssl-certificate-verification /tmp/vcsa-${var.deploy_type}.json"
  }
}

resource "null_resource" "vcsa_windows_deploy" {
  count = var.windows == true ? 1 : 0
  provisioner "local-exec" {
    command = "${local.binaries_path}/vcsa-cli-installer/win32/vcsa-deploy.exe install --accept-eula --acknowledge-ceip --no-ssl-certificate-verification /tmp/vcsa-${var.deploy_type}.json"
  }
}
