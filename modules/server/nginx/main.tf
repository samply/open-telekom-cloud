data "template_file" "auth_config" {
  template = file("${path.module}/auth.conf.tmpl")
}

data "ignition_file" "auth_config" {
  filesystem = "root"
  path       = "/etc/nginx/conf.d/auth.conf"
  mode       = "0644"
  content {
    content = data.template_file.auth_config.rendered
  }
}

data "template_file" "searchbroker_config" {
  template = file("${path.module}/searchbroker.conf.tmpl")
}

data "ignition_file" "searchbroker_config" {
  filesystem = "root"
  path       = "/etc/nginx/conf.d/searchbroker.conf"
  mode       = "0644"
  content {
    content = data.template_file.searchbroker_config.rendered
  }
}

data "template_file" "mdr_config" {
  template = file("${path.module}/mdr.conf.tmpl")
}

data "ignition_file" "mdr_config" {
  filesystem = "root"
  path       = "/etc/nginx/conf.d/mdr.conf"
  mode       = "0644"
  content {
    content = data.template_file.mdr_config.rendered
  }
}

data "template_file" "nginx_service" {
  template = file("${path.module}/nginx.service.tmpl")

  vars = {
    version = var.nginx_version
  }
}

data "ignition_systemd_unit" "nginx_service" {
  name    = "nginx.service"
  content = data.template_file.nginx_service.rendered
}
