# outputs.tf contain the defined outputs for the module

output "project_id" {
  description = "Project id for managed project."
  value       = google_project.project.project_id

  depends_on = [
    # The services for the project must be enabled before we try to make use of
    # them. Make the project id depend on the services to allow for this.
    google_project_service.project,

    # The owner service account must have the owner role before we can create
    # any resources. Make the project id depend on the IAM binding to allow for
    # this.
    google_project_iam_member.owner,
  ]
}

output "project_number" {
  description = "Project number for managed project."
  value       = google_project.project.number

  depends_on = [
    # The services for the project must be enabled before we try to make use of
    # them. Make the project id depend on the services to allow for this.
    google_project_service.project,

    # The owner service account must have the owner role before we can create
    # any resources. Make the project id depend on the IAM binding to allow for
    # this.
    google_project_iam_member.owner,
  ]
}

output "region" {
  description = <<EOI
Region for managed project. A copy of the input variable but it is dependent
on the project actually being created.
EOI
  value       = var.region
  depends_on  = [google_project.project]
}

output "owner_service_account_credentials" {
  description = "JSON credentials for owner service account."
  sensitive   = true
  value       = base64decode(google_service_account_key.owner.private_key)
}

output "owner_service_account_email" {
  description = "Email for the for owner service account."
  sensitive   = true
  value       = google_service_account.owner.email
}
