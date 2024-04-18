provider "google" {


}

module "gcp_project" {
    source = "../../modules/gcp_project"
    project_name = "test project"
    project_id = "test-project-id"
    labels = {
       "environment" = "test"
       "created_by" = "terraform"
    }
  
}