data "template_file" "haveged_service" {
  template = file("${path.module}/haveged.service.tmpl")
}

data "ignition_systemd_unit" "haveged_service" {
  name    = "haveged.service"
  content = data.template_file.haveged_service.rendered
}
