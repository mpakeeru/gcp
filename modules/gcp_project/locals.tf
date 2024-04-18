# locals.tf defines common expressions used by the module.

locals {
  # List of services which should be enabled in the project
  initially_enabled_project_services = [
    "serviceusage.googleapis.com"
  ]
}
