resource "yandex_lb_target_group" "ytg" {
  name      = "ytg-target-group"
  region_id = "ru-central1"
  folder_id = var.folder_id
  
  target {
    subnet_id = var.subnet_id
    address   = "${yandex_compute_instance.app[0].network_interface.0.ip_address}"
  }

target {
    subnet_id = var.subnet_id
    address   = "${yandex_compute_instance.app[0].network_interface.0.ip_address}"
  }
  }



resource "yandex_lb_network_load_balancer" "ylb" {
  name = "ylb-network-load-balancer"

  listener {
    name = "my-listener"
    port = 8080
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.ytg.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}

