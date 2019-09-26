output "init-network_service" {
  value = data.ignition_systemd_unit.init-network_service.id
}
