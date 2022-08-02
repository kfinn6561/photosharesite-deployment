variable "local_directory" {
  description = "where to store credentials"
  type        = string
}

variable "username" {
  description = "db username to use"
  type = string
}

variable "db_name" {
  description = "name of the database to use"
  type = string
}

variable "database" {
  description = "database from which to create credentials"
  type = object({
    name = string
    public_ip_address = string
  })
}