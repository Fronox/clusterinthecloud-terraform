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
    waldur_api_url = var.WALDUR_API_URL
    waldur_api_token = var.WALDUR_API_TOKEN
    waldur_order_item_uuid = var.WALDUR_ORDER_ITEM_UUID
    glauth_admin_uidnumber = var.GLAUTH_ADMIN_UIDNUMBER
    glauth_admin_password = var.GLAUTH_ADMIN_PASSWORD
    glauth_admin_password_digest = var.GLAUTH_ADMIN_PASSWORD_DIGEST
    glauth_admin_pgroup = var.GLAUTH_ADMIN_PGROUP
    cloud-platform = "oracle"
    fileserver-ip  = oci_file_storage_mount_target.ClusterFSMountTarget.hostname_label
    custom_block = templatefile("${path.module}/files/bootstrap_custom.sh.tpl", {})
    mgmt_hostname: local.mgmt_hostname
    citc_keys = var.ssh_public_key
  }
}
