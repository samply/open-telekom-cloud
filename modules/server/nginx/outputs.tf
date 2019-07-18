output "searchbroker_config_file" {
  value = data.ignition_file.searchbroker_config.id
}

output "mdr_config_file" {
  value = data.ignition_file.mdr_config.id
}

output "auth_config_file" {
  value = data.ignition_file.auth_config.id
}

output "nginx_service" {
  value = data.ignition_systemd_unit.nginx_service.id
}
