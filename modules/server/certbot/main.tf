data "template_file" "certbot_service" {
  template = file("${path.module}/certbot.service.tmpl")
  vars = {
    version = var.certbot_version
    email   = "notify@germanbiobanknode.de"
    domains = join(" -d ", var.certbot_domains)
  }
}

data "ignition_systemd_unit" "certbot_service" {
  name    = "certbot.service"
  content = data.template_file.certbot_service.rendered
}

data "template_file" "certbot_timer" {
  template = file("${path.module}/certbot.timer.tmpl")
}

data "ignition_systemd_unit" "certbot_timer" {
  name    = "certbot.timer"
  content = data.template_file.certbot_timer.rendered
}
