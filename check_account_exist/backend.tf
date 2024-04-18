terraform {
  backend "gcs" {
    bucket  = "terraform-state-85763"
    prefix  = "terraform/state/check_account_exist"
  }
}