variable "project_name" {
  description = "A human-readable project name."
  type        = string
  default = ""
}

variable "project_id" {
  description = "The id to use when creating the project."
  type        = string
  default = ""
}

variable "billing_account" {
  description = "Billing account to associate with generated project. Defaults to the master billing account."
  type        = string
  default     = ""
}

variable "folder_id" {
  description = "ID of folder to insert generated project into."
  type        = string
  default     = ""
}

variable "region" {
  description = "Region to create resources in."
  type        = string
  default     = "us-east1"
}

variable "additional_services" {
  description = <<EOI
List of services which should be enabled in the project in addition to any
manually enabled ones or ones enabled by Google's infrastructure.
EOI
  type        = list(string)
  default     = []
}

variable "editors" {
  description = <<EOI
List of project editors. This list is non-authoritative in that if someone
already has the role/editor role and does not appear in the list, they will
not be removed from the role. This is intentional since, otherwise, it would
be all to easy to remove all accounts you have access to and be unable to
manage the project.
EOI
  type        = list(string)
  default     = []
}

variable "skip_delete" {
  description = <<EOI
If true, deleting the project resource wont delete the actual GCP project.
This is useful to prevent deletion of manually created resources.
EOI
  type        = bool
  default     = true
}

variable "auto_create_network" {
  description = "Whether to create the 'default' network automatically"
  type        = bool
  default     = true
}

variable "labels" {
  description = "Set of key/value label pairs to assign to the project"
  type        = map(string)
  default     = {}
}

variable "log_retention" {
  description = "Override default 30 day log retention period (in days)"
  type        = number
  default     = null
}
