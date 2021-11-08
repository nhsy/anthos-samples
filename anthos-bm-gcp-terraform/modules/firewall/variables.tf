variable "network" {
  type    = string
  default = "default"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/8"
}

variable "unique_id" {
  type = string
}

variable "log_config_metadata" {
  description = ""
  type        = list(string)
  default = [
    "INCLUDE_ALL_METADATA"
  ]
}