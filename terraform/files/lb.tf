resource "yandex_lb_target_group" "reddit-app-servers" {
  name = "reddit-app-servers"

  dynamic target {
    for_each = yandex_compute_instance.app
    content {
      subnet_id = var.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "reddit-app-lb" {
  name = "reddit-app-load-balancer"

  listener {
    name        = "app9292"
    port        = 9292
    target_port = 9292
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.reddit-app-servers.id

    healthcheck {
      name = "http"
      http_options {
        port = 9292
      }
    }
  }
}
