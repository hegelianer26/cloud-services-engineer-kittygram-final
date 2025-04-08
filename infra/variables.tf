variable "TF_admin_ssh_key" {
  description = "SSH public key for accessing the instance by admin"
  type        = string
}

variable "TF_deploy_ssh_key" {
  description = "SSH public key for accessing the instance by deploy user"
  type        = string
}