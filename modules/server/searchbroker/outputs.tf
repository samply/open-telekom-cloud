output "searchbroker_service" {
  value = data.ignition_systemd_unit.searchbroker_service.id
}

output "searchbroker_ui_service" {
  value = data.ignition_systemd_unit.searchbroker_ui_service.id
}
