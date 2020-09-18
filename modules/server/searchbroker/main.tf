data "template_file" "searchbroker_service" {
  template = file("${path.module}/searchbroker.service.tmpl")
  vars = {
    version           = var.searchbroker_version
    mail_host         = "out-cloud.mms.t-systems-service.com"
    mail_from_address = "no-reply@germanbiobanknode.de"
    mail_from_name    = terraform.workspace == "default" ? "Sample Locator" : "TEST Sample Locator"
    auth_host         = "https://login.bbmri-eric.eu"
  }
}

data "ignition_systemd_unit" "searchbroker_service" {
  name    = "searchbroker.service"
  content = data.template_file.searchbroker_service.rendered
}

data "template_file" "searchbroker_ui_service" {
  template = file("${path.module}/searchbroker-ui.service.tmpl")
  vars = {
    version         = var.searchbroker-ui_version
    negotiator_url  = "https://negotiator.bbmri-eric.eu"
    locator_url     = terraform.workspace == "default" ? "https://samplelocator.bbmri.de" : format("https://samplelocator.%s.bbmri.de", terraform.workspace)
    auth_host       = "https://login.bbmri-eric.eu"
    mdr_api_url     = terraform.workspace == "default" ? "https://mdr.germanbiobanknode.de/v3/api/mdr" : format("https://mdr.%s.bbmri.de/v3/api/mdr", terraform.workspace)
    mdr_namespace   = "mdr16"
    mdr_language    = "en"
    mdr_mapping     = "[{\"nameOfEnum\": \"DONOR\",\"urn\": \"urn:mdr16:dataelementgroup:5:1\"},{\"nameOfEnum\": \"SAMPLE\",\"urn\": \"urn:mdr16:dataelementgroup:3:1\"},{\"nameOfEnum\": \"EVENT\", \"urn\": \"urn:mdr16:dataelementgroup:6:1\"}]"
    mdr_properties  = "[{\"urn\": \"urn:mdr16:dataelement:29:1\",\"placeholder\": \"\",\"unit\": \"kg\"},{\"urn\": \"urn:mdr16:dataelement:30:1\",\"placeholder\": \"\",\"unit\": \"cm\"},{\"urn\": \"urn:mdr16:dataelement:28:1\",\"placeholder\": \"\",\"unit\": \"years\"},{\"urn\": \"urn:mdr16:dataelement:14:1\",\"placeholder\": \"\",\"unit\": \"years\"},{\"urn\": \"urn:mdr16:dataelement:27:1\",\"placeholder\": \"e.g. C25.1\",\"unit\": \"\"}]"
    mdr_hidden      = "[\"urn:mdr16:dataelement:1:1\",\"urn:mdr16:dataelement:25:1\",\"urn:mdr16:dataelement:34:1\",\"urn:mdr16:dataelement:18:1\",\"urn:mdr16:dataelement:11:1\",\"urn:mdr16:dataelement:19:1\",\"urn:mdr16:dataelement:30:1\",\"urn:mdr16:dataelement:4:1\",\"urn:mdr16:dataelement:21:1\",\"urn:mdr16:dataelement:22:1\",\"urn:mdr16:dataelement:24:1\",\"urn:mdr16:dataelement:13:1\"]"
    feature_stratifier = terraform.workspace == "default" ? "false" : "true"
  }
}

data "ignition_systemd_unit" "searchbroker_ui_service" {
  name    = "searchbroker-ui.service"
  content = data.template_file.searchbroker_ui_service.rendered
}
