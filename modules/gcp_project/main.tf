/******************************************
  Project random id suffix configuration
 *****************************************/
resource "random_id" "project_id_suffix" {
  byte_length = 2
}



# The Google project which houses all of the resources.
resource "google_project" "project" {
  name                = var.project_name
  project_id          =  "${var.project_prefix}-${var.project_id}-${random_id.project_id_suffix.dec}"
  billing_account     = var.billing_account
  folder_id           = var.folder_id
  skip_delete         = var.skip_delete
  auto_create_network = var.auto_create_network
  labels              = var.labels
}

locals {
  # Form a list of all services to be enabled.
  all_services = concat(
    local.initially_enabled_project_services, var.additional_services
  )
}

# Additional services on the project.
resource "google_project_service" "project" {
  for_each           = toset(local.all_services)
  project            = google_project.project.project_id
  service            = each.key
  disable_on_destroy = false
}

# A service account owner for the project. This service account can be
# used subsequently to manage resources.
resource "google_service_account" "owner" {
  project      = google_project.project.project_id
  account_id   = "terraform-admin"
  display_name = "Project-specific terraform service account"
}

# The owner service account must have the "roles/owner" role.
resource "google_project_iam_member" "owner" {
  project = google_project.project.project_id
  role    = "roles/owner"
  member  = "serviceAccount:${google_service_account.owner.email}"
}

# A key which can be used to authenticate as the owner service account.
resource "google_service_account_key" "owner" {
  service_account_id = google_service_account.owner.name
}

# Project editors
resource "google_project_iam_member" "editors" {
  count   = length(var.editors)
  project = google_project.project.project_id
  role    = "roles/editor"
  member  = var.editors[count.index]
}

# Override log retention period
resource "google_logging_project_bucket_config" "_default_log" {
  count = var.log_retention != null ? 1 : 0

  project        = google_project.project.project_id
  location       = "global"
  retention_days = var.log_retention
  bucket_id      = "_Default"
}
