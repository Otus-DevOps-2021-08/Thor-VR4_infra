output "external_ip_address_app" {
  value = tolist([for inst in yandex_compute_instance.app : inst.network_interface.0.nat_ip_address])[*]
}
