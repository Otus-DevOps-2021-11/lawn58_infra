output "external_ip_address_app1" {
  value = yandex_compute_instance.app[0].network_interface.0.nat_ip_address
}
output "external_ip_address_app2" {
  value = yandex_compute_instance.app[1].network_interface.0.nat_ip_address
}
output "load_balancer_external_ip_address" {
  value = flatten(yandex_lb_network_load_balancer.ylb.listener[*].external_address_spec.*.address)[0]
}
