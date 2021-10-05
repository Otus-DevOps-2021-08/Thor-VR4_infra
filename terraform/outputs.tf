output "external_ip_address_app" {
  value = tolist([for inst in yandex_compute_instance.app : inst.network_interface.0.nat_ip_address])[*]
}
output "external_ip_address_lb" {
  value = tolist(
    tolist([
      for listener in yandex_lb_network_load_balancer.reddit-app-lb.listener : listener if listener.name == "app9292"
  ])[0].external_address_spec)[0].address
}
