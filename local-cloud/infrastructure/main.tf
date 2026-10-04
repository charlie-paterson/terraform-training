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
  }
}

provider "docker" {}

resource "docker_network" "local_cloud" {
  name = "local-cloud"
}
