variable "project" {
  description = "The GCP project ID"
  default = "terraform-85763"
}

variable "gcp_service_list" {
  type        = list(string)
  description = "The list of apis necessary for the project"
  default     = []
}

variable "service_accounts" {
  description = "List of service accounts to create"
  type        = list(object({
    project_id    = string
    names = list(string)
    display_name  = string
    description   = string
    descriptions = list(string)
    project_roles         = list(string)
  }))
  default = [ {
    project_id    = ""
    names = [""]
    display_name  = ""
    description   = ""
    descriptions = [""]
    project_roles         = [""]
  } ]
}


