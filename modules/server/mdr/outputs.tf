output "mdr_service" {
  value = data.ignition_systemd_unit.mdr_service.rendered
}

output "mdr_ui_service" {
  value = data.ignition_systemd_unit.mdr_ui_service.rendered
}
