data "ignition_directory" "etc_nginx" {
  filesystem = "root"
  path       = "/etc/nginx"
  mode       = "0755"
}

data "template_file" "acme-challenge_global" {
  template = file("${path.module}/acme-challenge.global.tmpl")
}

data "ignition_file" "acme-challenge_global" {
  filesystem = "root"
  path       = "/etc/nginx/conf.d/acme-challenge.global"
  mode       = "0644"
  content {
    content = data.template_file.acme-challenge_global.rendered
  }
}

data "template_file" "auth_config" {
  template = file("${path.module}/auth.conf.tmpl")
  vars = {
    subdomain = terraform.workspace == "default" ? "auth" : format("auth.%s", terraform.workspace)
  }
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
  vars = {
    subdomain = terraform.workspace == "default" ? "search" : format("search.%s", terraform.workspace)
  }
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
  vars = {
    subdomain = terraform.workspace == "default" ? "mdr" : format("mdr.%s", terraform.workspace)
  }
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
