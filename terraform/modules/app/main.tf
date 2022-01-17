resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat = true
  }

  metadata = {
  ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }


  connection {
  type = "ssh"
  host = yandex_compute_instance.app.network_interface.0.nat_ip_address
  user = "ubuntu"
  agent = false
  private_key = file("ubuntu")
  }

  provisioner "file" {
  source = "~/lawn58_infra/terraform/files/puma.service"
  destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
  script = "~/lawn58_infra/terraform/files/deploy.sh"
  }
}
