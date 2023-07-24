# Gets a list of Availability Domains
data "oci_identity_availability_domains" "ADs" {
  compartment_id = var.compartment_ocid
}

data "tls_public_key" "oci_public_key" {
  private_key_pem = file(var.private_key_path)
}

data "template_file" "user_data" {
  template = file("${path.module}/../common-files/bootstrap.sh.tpl")
  vars = {
    ansible_repo = var.ansible_repo
    ansible_branch = var.ansible_branch
    waldur_api_url = var.waldur_api_url
    waldur_api_token = var.waldur_api_token
    waldur_order_item_uuid = var.waldur_order_item_uuid
    glauth_admin_uidnumber = var.glauth_admin_uidnumber
    glauth_admin_pgroup = var.glauth_admin_pgroup
    glauth_admin_password = var.glauth_admin_password
    glauth_admin_password_digest = var.glauth_admin_password_digest
    cloud-platform = "oracle"
    fileserver-ip  = oci_file_storage_mount_target.ClusterFSMountTarget.hostname_label
    custom_block = templatefile("${path.module}/files/bootstrap_custom.sh.tpl", {})
    mgmt_hostname: local.mgmt_hostname
    citc_keys = var.ssh_public_key
  }
}
