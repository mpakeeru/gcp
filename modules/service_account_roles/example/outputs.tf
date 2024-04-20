
output "service_account_email" {
  description = "The email address of the created service account"
  value       = module.service_account_roles.service_account_email
}
