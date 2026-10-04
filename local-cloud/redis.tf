resource "docker_volume" "redis_data" {
  name = "local-cloud-redis-data"
}

resource "docker_image" "redis" {
  name = "redis:7"
}

resource "docker_container" "redis" {
  name  = "local-cloud-redis"
  image = docker_image.redis.image_id

  restart = "unless-stopped"

  networks_advanced {
    name = docker_network.local_cloud.name
  }

  ports {
    internal = 6379
    external = 6379
  }

  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }

  command = [
    "redis-server",
    "--appendonly",
    "yes"
  ]

  healthcheck {
    test     = ["CMD", "redis-cli", "ping"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}
