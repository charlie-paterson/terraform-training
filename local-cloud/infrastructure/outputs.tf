output "postgres_host" {
  description = "PostgreSQL host"
  value       = "localhost"
}

output "postgres_port" {
  description = "PostgreSQL port"
  value       = 5432
}

output "postgres_database" {
  description = "PostgreSQL database"
  value       = var.postgres_database
}

output "postgres_user" {
  description = "PostgreSQL username"
  value       = var.postgres_user
}

output "postgres_connection_string" {
  description = "PostgreSQL connection string"
  value       = "postgresql://${var.postgres_user}:<password>@localhost:5432/${var.postgres_database}"
}
