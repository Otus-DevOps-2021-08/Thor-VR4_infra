output "external_ip_address_db" {
  value = tolist([for inst in yandex_compute_instance.db : inst.network_interface.0.nat_ip_address])[*]
}
output "local_ip_address_db" {
  value = tolist([for inst in yandex_compute_instance.db : inst.network_interface.0.ip_address])[*]
}
