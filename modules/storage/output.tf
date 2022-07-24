output "admin-password" {
  value = random_password.admin-pwd.result
  description = "Password of the admin user of the database"
  sensitive = true
}