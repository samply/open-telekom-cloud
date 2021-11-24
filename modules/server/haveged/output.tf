output "haveged_service" {
  value = data.ignition_systemd_unit.haveged_service.rendered
  description = "The haveged.service systemd unit."
}
