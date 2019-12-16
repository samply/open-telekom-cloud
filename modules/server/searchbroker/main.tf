data "template_file" "searchbroker_service" {
  template = file("${path.module}/searchbroker.service.tmpl")
  vars = {
    version           = var.searchbroker_version
    mail_host         = "out-cloud.mms.t-systems-service.com"
    mail_from_address = "no-reply@germanbiobanknode.de"
    mail_from_name    = "Sample Locator"
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
    negotiator_url  = "https://negotiator.germanbiobanknode.de"
    auth_host       = "https://login.bbmri-eric.eu"
    mdr_api_url     = terraform.workspace == "default" ? "https://mdr.germanbiobanknode.de/v3/api/mdr" : format("https://mdr.%s.bbmri.de/v3/api/mdr", terraform.workspace)
    mdr_namespace   = "mdr16"
    mdr_language    = "en"
    mdr_mapping     = "<dataElementGroup nameOfEnum=\"DONOR\">urn:mdr16:dataelementgroup:5:1</dataElementGroup><dataElementGroup nameOfEnum=\"SAMPLE_CONTEXT\">urn:mdr16:dataelementgroup:4:1</dataElementGroup><dataElementGroup nameOfEnum=\"SAMPLE\">urn:mdr16:dataelementgroup:3:1</dataElementGroup><dataElementGroup nameOfEnum=\"EVENT\">urn:mdr16:dataelementgroup:6:1</dataElementGroup>"
    mdr_properties  = "<dataElement><urn>urn:mdr16:dataelement:29:1</urn><placeHolder></placeHolder><unit>kg</unit></dataElement><dataElement><urn>urn:mdr16:dataelement:30:1</urn><placeHolder></placeHolder><unit>cm</unit></dataElement><dataElement><urn>urn:mdr16:dataelement:28:1</urn><placeHolder></placeHolder><unit>years</unit></dataElement><dataElement><urn>urn:mdr16:dataelement:14:1</urn><placeHolder></placeHolder><unit>years</unit></dataElement><dataElement><urn>urn:mdr16:dataelement:27:1</urn><placeHolder>e.g. C25.1</placeHolder><unit></unit></dataElement>"
    mdr_hidden      = "<hiddenDataElement>urn:mdr16:dataelement:1:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:25:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:34:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:18:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:11:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:19:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:20:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:4:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:21:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:22:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:24:1</hiddenDataElement><hiddenDataElement>urn:mdr16:dataelement:13:1</hiddenDataElement>"
  }
}

data "ignition_systemd_unit" "searchbroker_ui_service" {
  name    = "searchbroker-ui.service"
  content = data.template_file.searchbroker_ui_service.rendered
}
