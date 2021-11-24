output "nginx_config_file" {
  value = data.ignition_file.nginx_config.rendered
}

output "etc_nginx_dir" {
  value = data.ignition_directory.etc_nginx.rendered
}

output "acme-challenge_global_file" {
  value = data.ignition_file.acme-challenge_global.rendered
}

output "searchbroker_config_file" {
  value = data.ignition_file.searchbroker_config.rendered
}

output "mdr_config_file" {
  value = data.ignition_file.mdr_config.rendered
}

output "nginx_service" {
  value = data.ignition_systemd_unit.nginx_service.rendered
}
