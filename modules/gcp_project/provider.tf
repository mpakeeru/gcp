terraform {
  # Specify the required providers and their version restrictions.
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.0.0"
    }
  }

  required_version = ">= 0.12"
}
