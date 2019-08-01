output "auth_service" {
  value = data.ignition_systemd_unit.auth_service.id
}
