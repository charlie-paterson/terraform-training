variable "postgres_database" {
  description = "PostgreSQL database name"
  type        = string
  default     = "localcloud"
}

variable "postgres_user" {
  description = "PostgreSQL username"
  type        = string
  default     = "localcloud"
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}
