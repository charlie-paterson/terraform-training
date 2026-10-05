terraform {
  backend "local" {
    path = "/home/pater/terraform-state/local-cloud/terraform.tfstate"
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }

    aws = {
      source = "hashicorp/aws"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4"
    }
  }
}

provider "docker" {}

provider "archive" {}

resource "docker_network" "local_cloud" {
  name = "local-cloud"
}
