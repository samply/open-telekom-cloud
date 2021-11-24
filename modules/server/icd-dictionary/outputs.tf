output "icd_dictionary_service" {
  value = data.ignition_systemd_unit.icd_dictionary_service.rendered
}
