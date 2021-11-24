output "certbot_service" {
  value = data.ignition_systemd_unit.certbot_service.rendered
}

output "certbot_timer" {
  value = data.ignition_systemd_unit.certbot_timer.rendered
}
