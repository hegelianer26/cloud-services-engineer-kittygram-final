resource "yandex_vpc_address" "addr" {
  name = "vm-adress"
  external_ipv4_address {
    zone_id = var.zone
  }
}

resource "yandex_vpc_network" "this" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "this" {
  name = var.subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = ["192.168.0.0/28"]
}

data "yandex_compute_image" "ubuntu-24-04" {
  family    = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "this" {
  name        = var.instance_name
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-24-04.id
      size = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this.id
    nat       = true
    nat_ip_address = yandex_vpc_address.addr.external_ipv4_address[0].address
    security_group_ids = [yandex_vpc_security_group.this.id]
  }


  metadata = {
    user-data = templatefile("cloud-init.yaml", {
        admin_ssh_key = var.admin_ssh_key
        deploy_ssh_key = var.deploy_ssh_key
    })
  }
}

resource "yandex_vpc_security_group" "this" {
  name        = var.security_group_name
  network_id  = yandex_vpc_network.this.id


  ingress {
    protocol       = "TCP"
    description    = "Разрешаем входящий SSH трафик"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "Разрешаем входящий HTTP трафик"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  egress {
    protocol       = "ANY"
    description    = "Разрешаем весь исходящий трафик"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
