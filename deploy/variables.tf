variable "namespace" {
  description   = "The namespace for the workload identity"
  type          = string
  default       = "utils"
}

variable "application_name" {
  description   = "Application Name"
  type          = string
}