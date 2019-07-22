data "template_file" "mdr_service" {
  template = file("${path.module}/mdr.service.tmpl")

  vars = {
    version = "4.0.3-SNAPSHOT"
    auth_host = "https://auth.dev.germanbiobanknode.de"
    auth_public_key = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA/D51sGPXYNn/2cYYxCB5bP0JMRrWXhn3qmCIwrJCO8VgmsT9DiRJz/EmiP6qOrC3NMYSaELBGgaQeb690mqIMxY/5qkfIbNJYuV7F2gcPQFWxY2neO24XnFXQqsA0PcdlF5lB0HPCYKoqjV1hVtBl9IS8/v8mJ1FMa4oifGD8AqrLEQkItkEK+yg53rbs0sxlEFYp1U4gogmW6MdQ1ZDfCLiL6eWBFWRpHZAzXxfkauoxcccReH6hv7DPkI3ngxxARx8ivcLS+psJOe8RL2LrlS49flbazOWBmG/f3DFdoEcXYcraSnFc9lx7SJK4xsL6mBv6Tc1Qtf0nuAG+3bLICe9M0pE62z9wSVebe4F7htfElSr7MS2EMXX5iW0whe1RrsPojPY12ZEKOL7WGvJTyDOnA2Nzp22p5Ii/wru1uNaD/7xsw4OcMxHaYFi87dJSbsfx1OEXP3Co+zWZ2B1WdV83bvlx7NNHsATYeQuKG7IeBco+oYoXAjOk7IBlc0M6WqOpuXuBNXOGpvPR4aRd0COYXIZd+DqoK3ZLCr7gEYHHeCUx6Y8cKLK4sxbhHjGqusjVEPYdM46txSawNNIhp0LtfDilWWwecYX3N0WIPFElfKL43tIrjVrzsfL7nECsapVByhqBGFZX+mY2gEprBnqDCrVeUELmKiwm+ioQtkCAwEAAQ=="
    auth_client_id = "mdr-client-id"
  }
}

data "ignition_systemd_unit" "mdr_service" {
  name    = "mdr.service"
  content = data.template_file.mdr_service.rendered
}

data "template_file" "mdr_ui_service" {
  template = file("${path.module}/mdr-ui.service.tmpl")

  vars = {
    version = "2.0.5-SNAPSHOT"
    auth_host = "https://auth.dev.germanbiobanknode.de"
    auth_public_key = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA/D51sGPXYNn/2cYYxCB5bP0JMRrWXhn3qmCIwrJCO8VgmsT9DiRJz/EmiP6qOrC3NMYSaELBGgaQeb690mqIMxY/5qkfIbNJYuV7F2gcPQFWxY2neO24XnFXQqsA0PcdlF5lB0HPCYKoqjV1hVtBl9IS8/v8mJ1FMa4oifGD8AqrLEQkItkEK+yg53rbs0sxlEFYp1U4gogmW6MdQ1ZDfCLiL6eWBFWRpHZAzXxfkauoxcccReH6hv7DPkI3ngxxARx8ivcLS+psJOe8RL2LrlS49flbazOWBmG/f3DFdoEcXYcraSnFc9lx7SJK4xsL6mBv6Tc1Qtf0nuAG+3bLICe9M0pE62z9wSVebe4F7htfElSr7MS2EMXX5iW0whe1RrsPojPY12ZEKOL7WGvJTyDOnA2Nzp22p5Ii/wru1uNaD/7xsw4OcMxHaYFi87dJSbsfx1OEXP3Co+zWZ2B1WdV83bvlx7NNHsATYeQuKG7IeBco+oYoXAjOk7IBlc0M6WqOpuXuBNXOGpvPR4aRd0COYXIZd+DqoK3ZLCr7gEYHHeCUx6Y8cKLK4sxbhHjGqusjVEPYdM46txSawNNIhp0LtfDilWWwecYX3N0WIPFElfKL43tIrjVrzsfL7nECsapVByhqBGFZX+mY2gEprBnqDCrVeUELmKiwm+ioQtkCAwEAAQ=="
    auth_client_id = "mdr-client-id"
  }
}

data "ignition_systemd_unit" "mdr_ui_service" {
  name    = "mdr-ui.service"
  content = data.template_file.mdr_ui_service.rendered
}
