output "searchbroker_service" {
  value = data.ignition_systemd_unit.searchbroker_service.rendered
}

output "searchbroker_ui_service" {
  value = data.ignition_systemd_unit.searchbroker_ui_service.rendered
}
