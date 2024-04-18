provider "google" {
 
}
module "service_accounts_json_input" {
  source = "../../modules/service_accounts_json_input"
  service_accounts_json_file = "./service_accounts.json"
}