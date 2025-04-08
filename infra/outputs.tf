output "public-ip-address-for-vm-1" {
  description = "Public IP address for vm-1"
  value       = yandex_compute_instance.this.network_interface.0.nat_ip_address
}

