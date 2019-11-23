variable "gcp_project_id" {
  default = "sunlit-descent-240209"
}
variable "gcp_region" {
  default = "europe-west4"
}
variable "gcp_zone" {
  default = "europe-west4-c"
}
variable "gcp_credentials_file" {
  default = ""
}
variable "environment" {
  type = string
  default = "dev"
}

variable "machine_types" {
  type = "map"
  default = {
    "dev" = "f1-micro"
    "test" = "n1-highcpu-32"
    "prod" = "n1-highcpu-32"
  }
}

variable "web_instance_count" {
  type    = number
  default = 1
}

variable "cidrs" {
  type = list(string)
  default = [
    "10.0.0.0/16",
    "10.1.0.0/16"]
}
