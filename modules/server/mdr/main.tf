data "template_file" "mdr_service" {
  template = file("${path.module}/mdr.service.tmpl")
  vars = {
    version         = var.mdr_version
    auth_host       = "https://login.mitro.dkfz.de"
    auth_public_key = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyOLKpu4syqh/ZHWF6cyY4wj3PKtPYCiZsMA56FQlIjmYs3Xa5dz9GcZg2nVFb4nKIc64crpBPWRmEQH8xYJQYmKx51IRCUN/Zh0OSRjLUbQnuivMZyTn2fyjkcTZFyyZfyyF2bUWyTfOINRNUVzPBOD+vtO5LHhCizrzqCOX8pidWoO5HWgkdIJ2/vsOYxhheAiRi8HI/o6qZyFcTua1JIUVfNG/1R9RHCqr5pm49a6+ffoh2T3fii/pQJ4JFLKu3nZG5Y82gP2al/IsAT23+FnLwqmKKTYxINbB/wwJpKVo4Rda74IbfYJoDWQgZHWWL/fFbbq/RXeRqBbYuHW51vdGB5F4EGV3u+9c+/rTvXTnGQAZjIpNbLtu14dUCT0KP/TSJ0vJ+2jRzTbQb1Q/ME1rHNPOZWb67j4qJUzKnymPsGkSM9m6sOSZgh7Xtf8ST1/K9GWHqwzG5JO+UpmdbrBvveRZSJWzXYry3u+6XqhTaEKSoDY428vaIXkTq8LFfNxilpF25PLzolbhmKCWgezsTHyg5Z08ys9teGhenraQBtBrsAQMVaJpZxYGpv8BCbQnyOQbUwxSGEexa4iqEyUYUBx3dgX3iybBKbUm9S7CYj6tuvkTbfMQkqdS3bRJIGfftUv81AJ5aC6S/I+UZhwqVJKy/5HtGdf8HKh+Gc0CAwEAAQ=="
    auth_client_id  = "gba-mdr"
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
    auth_public_key = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAyOLKpu4syqh/ZHWF6cyY4wj3PKtPYCiZsMA56FQlIjmYs3Xa5dz9GcZg2nVFb4nKIc64crpBPWRmEQH8xYJQYmKx51IRCUN/Zh0OSRjLUbQnuivMZyTn2fyjkcTZFyyZfyyF2bUWyTfOINRNUVzPBOD+vtO5LHhCizrzqCOX8pidWoO5HWgkdIJ2/vsOYxhheAiRi8HI/o6qZyFcTua1JIUVfNG/1R9RHCqr5pm49a6+ffoh2T3fii/pQJ4JFLKu3nZG5Y82gP2al/IsAT23+FnLwqmKKTYxINbB/wwJpKVo4Rda74IbfYJoDWQgZHWWL/fFbbq/RXeRqBbYuHW51vdGB5F4EGV3u+9c+/rTvXTnGQAZjIpNbLtu14dUCT0KP/TSJ0vJ+2jRzTbQb1Q/ME1rHNPOZWb67j4qJUzKnymPsGkSM9m6sOSZgh7Xtf8ST1/K9GWHqwzG5JO+UpmdbrBvveRZSJWzXYry3u+6XqhTaEKSoDY428vaIXkTq8LFfNxilpF25PLzolbhmKCWgezsTHyg5Z08ys9teGhenraQBtBrsAQMVaJpZxYGpv8BCbQnyOQbUwxSGEexa4iqEyUYUBx3dgX3iybBKbUm9S7CYj6tuvkTbfMQkqdS3bRJIGfftUv81AJ5aC6S/I+UZhwqVJKy/5HtGdf8HKh+Gc0CAwEAAQ=="
    auth_client_id  = "gba-mdr"
  }
}

data "ignition_systemd_unit" "mdr_ui_service" {
  name    = "mdr-ui.service"
  content = data.template_file.mdr_ui_service.rendered
}
