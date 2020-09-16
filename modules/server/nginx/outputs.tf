output "nginx_config_file" {
  value = data.ignition_file.nginx_config.id
}

output "etc_nginx_dir" {
  value = data.ignition_directory.etc_nginx.id
}

output "acme-challenge_global_file" {
  value = data.ignition_file.acme-challenge_global.id
}

output "searchbroker_config_file" {
  value = data.ignition_file.searchbroker_config.id
}

output "mdr_config_file" {
  value = data.ignition_file.mdr_config.id
}

output "nginx_service" {
  value = data.ignition_systemd_unit.nginx_service.id
}
