# main.tf

provider "google" {

}

resource "google_service_account" "account" {
  account_id   = "sa-nb-${lower(var.service_account_id)}-${lower(var.environment)}"
  display_name = "Service Account for ${var.service_account_id}"
}

resource "google_project_iam_binding" "service_account" {
  project = var.project_id
  role    = var.role
  
  members = [
    "serviceAccount:${google_service_account.account.email}"
  ]
}


module "iam_service_accounts_iam" {
  source  = "terraform-google-modules/iam/google//modules/service_accounts_iam"
  version = "7.7.1"
    
}