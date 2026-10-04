resource "docker_volume" "minio_data" {
  name = "local-cloud-minio-data"
}

resource "docker_image" "minio" {
  name = "minio/minio:latest"
}

resource "docker_container" "minio" {
  name  = "local-cloud-minio"
  image = docker_image.minio.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.local_cloud.name
  }

  ports {
    internal = 9000
    external = 9000
  }

  ports {
    internal = 9001
    external = 9001
  }

  env = [
    "MINIO_ROOT_USER=localcloud",
    "MINIO_ROOT_PASSWORD=${var.minio_password}"
  ]

  command = [
    "server",
    "/data",
    "--console-address",
    ":9001"
  ]

  volumes {
    volume_name    = docker_volume.minio_data.name
    container_path = "/data"
  }

  healthcheck {
    test     = ["CMD", "mc", "ready", "local"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}
