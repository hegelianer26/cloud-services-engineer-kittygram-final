variable "TF_admin_ssh_key" {
  description = "SSH public key for accessing the instance by admin"
  type        = string
}

variable "TF_deploy_ssh_key" {
  description = "SSH public key for accessing the instance by deploy user"
  type        = string
}

variable "TF_service_account_key_file" {
  description = "Path to the service account key file (JSON)"
  type        = string
}

variable "TF_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "TF_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "TF_zone" {
  description = "Default availability zone"
  default     = "ru-central1-a"
}