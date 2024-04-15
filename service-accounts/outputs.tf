output "service_account_emails" {
  value = {
    for idx, account in module.service_accounts : idx => account.email
  }
}