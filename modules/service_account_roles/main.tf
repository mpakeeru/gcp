

# Create service account
resource "google_service_account" "service_account" {
  account_id   = "sa-nb-${lower(var.service_account_name)}-${lower(var.environment)}"
  display_name = var.service_account_name
  project = var.project_id
}

# Assign project-level role to service account
resource "google_project_iam_member" "project_role" {
  project = var.project_id
  role    = var.project_role
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

# Assign organization-level roles to service account and user
resource "google_organization_iam_binding" "org_roles" {
  for_each = var.organization_roles

  org_id  = var.org_id
  role    = each.key
  members = [
    "user:${var.user_email}",
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
