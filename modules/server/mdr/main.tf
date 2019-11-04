data "template_file" "mdr_service" {
  template = file("${path.module}/mdr.service.tmpl")
  vars = {
    version         = var.mdr_version
    auth_host       = "https://login.mitro.dkfz.de"
  }
}

data "ignition_systemd_unit" "mdr_service" {
  name    = "mdr.service"
  content = data.template_file.mdr_service.rendered
}

data "template_file" "mdr_ui_service" {
  template = file("${path.module}/mdr-ui.service.tmpl")
  vars = {
    version         = var.mdr-ui_version
    auth_host       = "https://login.mitro.dkfz.de"
  }
}

data "ignition_systemd_unit" "mdr_ui_service" {
  name    = "mdr-ui.service"
  content = data.template_file.mdr_ui_service.rendered
}
