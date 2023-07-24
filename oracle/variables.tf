variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
}

variable "compartment_ocid" {
}

variable "ssh_public_key" {
}

variable "ManagementAD" {
  description = "The AD the management node should live in."
  default     = "1"
}

variable "FilesystemAD" {
  description = "The AD the filesystem should live in."
  default     = "1"
}

variable "ManagementShape" {
  description = "The shape to use for the management node"
  default     = "VM.Standard2.1"
}

variable "ExportPathFS" {
  default = "/shared"
}

variable "ansible_repo" {
  default = "https://github.com/clusterinthecloud/ansible.git"
}

variable "ansible_branch" {
  default = "6"
}

variable "waldur_api_url" {
  type = string
  description = "Waldur API URL, e.g. https://waldur.example.com/api/"
}

variable "waldur_api_token" {
  type = string
  description = "Token for Waldur API access"
}

variable "waldur_order_item_uuid" {
  type = string
  description = "Order item UUID from Waldur"
}

variable "glauth_admin_uidnumber" {
  type = string
  description = "User number for admin user in Glauth"
}

variable "glauth_admin_pgroup" {
  type = string
  description = "Group number for admin user in Glauth"
}

variable "glauth_admin_password" {
  type = string
  description = "Password for admin user in Glauth"
}

variable "glauth_admin_password_digest" {
  type = string
  description = "Password digest for admin user in Glauth"
}
