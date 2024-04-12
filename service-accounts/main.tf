

provider "google" {
  project = var.project

}

# Read the JSON input file
locals {
  service_accounts_json = jsondecode(file("service_accounts.json"))
}


module "service_accounts" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.0.0"
  for_each = { for idx, account in local.service_accounts_json : idx => account }
  project_id    = each.value.project_id
  names = each.value.names
  display_name = each.value.display_name
  description = each.value.description
  descriptions = each.value.descriptions
  project_roles = each.value.project_roles
}


