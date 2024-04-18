

# Read the JSON input file
locals {
  service_accounts_json = jsondecode(file(var.service_accounts_json_file))
}

module "service_accounts" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.2.2"
  for_each = { for idx, account in local.service_accounts_json : idx => account }
  
  #Map JSON data to module inputs
  project_id    = each.value.project_id
  names         = each.value.names
  display_name  = each.value.display_name
  description   = each.value.description
  descriptions  = each.value.descriptions
  project_roles = each.value.project_roles
}