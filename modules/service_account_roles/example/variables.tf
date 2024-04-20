variable "service_account_name" {
  description = "The name of the service account to create"
}

variable "project_id" {
  description = "The ID of the project"
}

variable "project_role" {
  description = "The project-level role to assign to the service account"
}

variable "organization_roles" {
  description = "A map of organization-level roles to assign to the service account and user"
  type        = map(list(string))
}

variable "user_email" {
  description = "The email address of the user to assign as owner at project level and assign organization roles"
}

variable "org_id" {
  description = "The ID of the organization"
}

variable "environment" {
  description = "The ID of the organization"
}
