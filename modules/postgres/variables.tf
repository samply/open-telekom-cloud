variable "vpc" {
  type = "string"
}

variable "subnet" {
  type = "string"
}

variable "zone" {
  type = "string"
}

variable "db_passwd" {
  type        = "string"
  description = "The password of the Postgres DB."
}
