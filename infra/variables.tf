variable "admin_ssh_key" {
  description = "SSH public key for accessing the instance by admin"
  type        = string
}

variable "deploy_ssh_key" {
  description = "SSH public key for accessing the instance by deploy user"
  type        = string
}

variable "service_account_key_file" {
  description = "Path to the service account key file (JSON)"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Default availability zone"
  default     = "ru-central1-a"
}

variable "bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "terraform-state-bucket"
}