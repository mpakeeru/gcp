# check_service_account.tf


data "terraform_remote_state" "service_account_state" {
  backend = "gcs"  # Using Google Cloud Storage (GCS) as the backend
  config = {
    bucket  = "terraform-state-85763"
    prefix  = "terraform/state/service-accounts"  
  }
}

resource "null_resource" "fetch_remote_state" {
  provisioner "local-exec" {
    command = <<-EOT
      terraform state pull \
        -backend-config="bucket=terraform-state-85763" \
        -backend-config="prefix=terraform/state/service-accounts"> remote_state.json
    EOT
  }
}

resource "null_resource" "check_service_account" {
  triggers = {
    always_run = "${timestamp()}"
  }
  provisioner "local-exec" {
    command = "bash check_service_account.sh ${var.project} ${var.account_id} > ./service_account_result"
  }
}

data "local_file" "service_account_result" {
  depends_on = [null_resource.check_service_account]
  filename   = "./service_account_result"
}

output "service_account_exists" {
  value = data.local_file.service_account_result.content
}
