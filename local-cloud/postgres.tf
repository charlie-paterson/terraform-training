resource "docker_volume" "postgres_data" {
  name = "local-cloud-postgres-data"
}

resource "docker_image" "postgres" {
  name = "postgres:16"
}

resource "docker_container" "postgres" {
  name  = "local-cloud-postgres"
  image = docker_image.postgres.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.local_cloud.name
  }

  env = [
    "POSTGRES_DB=${var.postgres_database}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}"
  ]

  ports {
    internal = 5432
    external = 5432
  }

  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U ${var.postgres_user} -d ${var.postgres_database}"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}
