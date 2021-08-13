//---------------resource of aws
variable "region" {
  type = string
  default = "eu-central-1"
}

variable "az_count" {
  description = "Number of AZs on region"
  default = "2"
}

// ------------names of project--------------
variable "app_name" {
  type = string
  default = "to_do"
}

variable "env" {
  default = "dev"
}
// -------------end of project names-----------------

// ---------------vpc--------------------------------
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = [
    "10.0.10.0/24",
    "10.0.20.0/24"
  ]
}

variable "private_subnet_cidr" {
  default = [
    "10.0.100.0/24",
    "10.0.200.0/24"
  ]
}
// ---------------------end of vpc---------------------