output "server" {
  value = opentelekomcloud_compute_instance_v2.server
}

output "ignition_config" {
  value = data.ignition_config.server.rendered
}
