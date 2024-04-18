provider "google" {
  project = var.project

}
data "google_service_account" "example" {
  # Assuming the service account with name "my-service-account" may or may not exist
  account_id = "my-service-account"
  project = var.project

  
}

# Check if the service account exists
locals {
  service_account_exists = try(length(data.google_service_account.example[*]), 0) > 0
}