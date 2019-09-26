data "template_file" "init-network_service" {
  template = file("${path.module}/init-network.service.tmpl")
}

data "ignition_systemd_unit" "init-network_service" {
  name    = "init-network.service"
  content = data.template_file.init-network_service.rendered
}
