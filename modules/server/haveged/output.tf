output "haveged_service" {
  value = data.ignition_systemd_unit.haveged_service.id
  description = "The haveged.service systemd unit."
}
