output "certbot_service" {
  value = data.ignition_systemd_unit.certbot_service.id
}

output "certbot_timer" {
  value = data.ignition_systemd_unit.certbot_timer.id
}