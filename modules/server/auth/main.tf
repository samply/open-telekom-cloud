data "template_file" "auth_service" {
  template = file("${path.module}/auth.service.tmpl")
  vars = {
    version           =  var.auth_version
    auth_host         = terraform.workspace == "default" ? "https://auth.germanbiobanknode.de" : format("https://auth.%s.germanbiobanknode.de", terraform.workspace)
    mail_host         = "out-cloud.mms.t-systems-service.com"
    mail_from_address = "no-reply@germanbiobanknode.de"
    mail_from_name    = "Samply Auth"
  }
}

data "ignition_systemd_unit" "auth_service" {
  name    = "auth.service"
  content = data.template_file.auth_service.rendered
}
