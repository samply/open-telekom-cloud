data "template_file" "icd_dictionary_service" {
  template = file("${path.module}/icd-dictionary.service.tmpl")
  vars     = {
    version = var.icd_dictionary_version
  }
}

data "ignition_systemd_unit" "icd_dictionary_service" {
  name    = "icd-dictionary.service"
  content = data.template_file.icd_dictionary_service.rendered
}
