variable "secret_key" {
  type        = "string"
  description = "The Open Telekom Cloud secret key."
}

variable "vpc_name" {
  type        = "string"
  description = "Name of the Virtual Private Cloud, We use prod and test here."
}

variable "db_passwd" {
  type        = "string"
  description = "The password of the Postgres DB."
}

