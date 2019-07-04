data "template_file" "searchbroker_service" {
  template = file("${path.module}/searchbroker.service.tmpl")

  vars = {
    version = "2.2.0"
    mail_host = "out-cloud.mms.t-systems-service.com"
    mail_from_address = "no-reply@germanbiobanknode.de"
    mail_from_name = "Sample Locator"
    auth_host = "https://auth.dev.germanbiobanknode.de"
    auth_public_key = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA/D51sGPXYNn/2cYYxCB5bP0JMRrWXhn3qmCIwrJCO8VgmsT9DiRJz/EmiP6qOrC3NMYSaELBGgaQeb690mqIMxY/5qkfIbNJYuV7F2gcPQFWxY2neO24XnFXQqsA0PcdlF5lB0HPCYKoqjV1hVtBl9IS8/v8mJ1FMa4oifGD8AqrLEQkItkEK+yg53rbs0sxlEFYp1U4gogmW6MdQ1ZDfCLiL6eWBFWRpHZAzXxfkauoxcccReH6hv7DPkI3ngxxARx8ivcLS+psJOe8RL2LrlS49flbazOWBmG/f3DFdoEcXYcraSnFc9lx7SJK4xsL6mBv6Tc1Qtf0nuAG+3bLICe9M0pE62z9wSVebe4F7htfElSr7MS2EMXX5iW0whe1RrsPojPY12ZEKOL7WGvJTyDOnA2Nzp22p5Ii/wru1uNaD/7xsw4OcMxHaYFi87dJSbsfx1OEXP3Co+zWZ2B1WdV83bvlx7NNHsATYeQuKG7IeBco+oYoXAjOk7IBlc0M6WqOpuXuBNXOGpvPR4aRd0COYXIZd+DqoK3ZLCr7gEYHHeCUx6Y8cKLK4sxbhHjGqusjVEPYdM46txSawNNIhp0LtfDilWWwecYX3N0WIPFElfKL43tIrjVrzsfL7nECsapVByhqBGFZX+mY2gEprBnqDCrVeUELmKiwm+ioQtkCAwEAAQ=="
    auth_client_id = "aun53c97n41iu"
  }
}

data "ignition_systemd_unit" "searchbroker_service" {
  name    = "searchbroker.service"
  content = data.template_file.searchbroker_service.rendered
}

data "template_file" "searchbroker_ui_service" {
  template = file("${path.module}/searchbroker-ui.service.tmpl")

  vars = {
    version = "2.3.3"
    negotiator_url = "https://negotiator.germanbiobanknode.de"
    auth_client_id = "aun53c97n41iu"
    auth_host = "https://auth.dev.germanbiobanknode.de"
    auth_public_key = "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA/D51sGPXYNn/2cYYxCB5bP0JMRrWXhn3qmCIwrJCO8VgmsT9DiRJz/EmiP6qOrC3NMYSaELBGgaQeb690mqIMxY/5qkfIbNJYuV7F2gcPQFWxY2neO24XnFXQqsA0PcdlF5lB0HPCYKoqjV1hVtBl9IS8/v8mJ1FMa4oifGD8AqrLEQkItkEK+yg53rbs0sxlEFYp1U4gogmW6MdQ1ZDfCLiL6eWBFWRpHZAzXxfkauoxcccReH6hv7DPkI3ngxxARx8ivcLS+psJOe8RL2LrlS49flbazOWBmG/f3DFdoEcXYcraSnFc9lx7SJK4xsL6mBv6Tc1Qtf0nuAG+3bLICe9M0pE62z9wSVebe4F7htfElSr7MS2EMXX5iW0whe1RrsPojPY12ZEKOL7WGvJTyDOnA2Nzp22p5Ii/wru1uNaD/7xsw4OcMxHaYFi87dJSbsfx1OEXP3Co+zWZ2B1WdV83bvlx7NNHsATYeQuKG7IeBco+oYoXAjOk7IBlc0M6WqOpuXuBNXOGpvPR4aRd0COYXIZd+DqoK3ZLCr7gEYHHeCUx6Y8cKLK4sxbhHjGqusjVEPYdM46txSawNNIhp0LtfDilWWwecYX3N0WIPFElfKL43tIrjVrzsfL7nECsapVByhqBGFZX+mY2gEprBnqDCrVeUELmKiwm+ioQtkCAwEAAQ=="
    mdr_api_url = "https://mdr.germanbiobanknode.de/v3/api/mdr"
    mdr_namespace = "mdr16"
    mdr_language = "en"
    mdr_mapping = "<dataElementGroup nameOfEnum=\"DONOR\">urn:mdr16:dataelementgroup:5:1</dataElementGroup><dataElementGroup nameOfEnum=\"SAMPLE_CONTEXT\">urn:mdr16:dataelementgroup:4:1</dataElementGroup><dataElementGroup nameOfEnum=\"SAMPLE\">urn:mdr16:dataelementgroup:3:1</dataElementGroup><dataElementGroup nameOfEnum=\"EVENT\">urn:mdr16:dataelementgroup:6:1</dataElementGroup>"
    mdr_hidden = "<hiddenDataElement>urn:mdr16:dataelement:1:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:25:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:34:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:18:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:11:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:19:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:20:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:4:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:21:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:22:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:24:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:13:1</hiddenDataElement>"
  }
}

data "ignition_systemd_unit" "searchbroker_ui_service" {
  name    = "searchbroker-ui.service"
  content = data.template_file.searchbroker_ui_service.rendered
}
