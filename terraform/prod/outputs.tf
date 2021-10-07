output "external_ip_address_app" {
  value = module.app.external_ip_address_app
}
#output "external_ip_address_lb" {
#  value = tolist(
#    tolist([
#      for listener in yandex_lb_network_load_balancer.reddit-app-lb.listener : listener if listener.name == "app9292"
#  ])[0].external_address_spec)[0].address
#}
output "external_ip_address_db" {
  value = module.db.external_ip_address_db
}
output "local_ip_address_db" {
  value = module.db.local_ip_address_db
}
