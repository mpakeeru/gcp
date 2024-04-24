# variables.tf

variable "project_id" {
  description = "The ID of the Google Cloud project"
  type = string
}

variable "service_account_id" {
  description = "The ID for the new service account"
  type = string
}

variable "environment" {
  description = "The environment prod/non-prod"
  type = string
}

variable "project_role" {
  description = "The role for service account"
  type = string
}

# User email
variable "user_email" {
  type    = string
  default = "mamathasama@gmail.com"
}

# List of roles to assign
variable "org_roles" {
  type = list(string)
  default = [
    "roles/iam.serviceAccountKeyAdmin",
    "roles/iam.serviceAccountTokenCreator"
    # Add more roles as needed
  ]
}
