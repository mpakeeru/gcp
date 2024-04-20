provider "google" {

}

module "service_account_roles" {
  source = "../../../modules/service_account_roles"

  service_account_name = var.service_account_name
  project_id           = var.project_id
  project_role         = var.project_role
  organization_roles   = var.organization_roles
  user_email           = var.user_email
  org_id               = var.org_id
  environment          = var.environment


}

