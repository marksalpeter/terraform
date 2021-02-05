terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.11.0"
    }
  }
}

# jenkins
variable "jenkins_home" {
  description = "the bind point for the jenkins home directory"
  default     = "~/jenkins_home"
}

provider "docker" {}

resource "docker_image" "jenkins" {
  name         = "jenkins/jenkins:latest"
  keep_locally = false
}

resource "docker_container" "jenkins" {
  image = docker_image.jenkins.latest
  name  = "jenkins"
  ports {
    internal = 8080
    external = 8080
  }
  host {
    host = "mailhog"
    ip   = docker_container.mailhog.network_data[0].ip_address
  }
  mounts {
    type   = "bind"
    source = pathexpand(var.jenkins_home)
    target = "/var/jenkins_home"
  }
  # mounts {
  #   type   = "bind"
  #   source = "/var/run/docker.sock"
  #   target = "/var/run/docker.sock"
  # }
}

locals {
  jenkins_server_url = "${docker_container.jenkins.ports[0].ip}:${docker_container.jenkins.ports[0].external}"
}

output "jenkins_server_url" {
  description = "jenkins server url"
  value       = local.jenkins_server_url
}

output "jenkins_home" {
  description = "jenkins server url"
  value       = var.jenkins_home
}

# mailhog
resource "docker_image" "mailhog" {
  name         = "mailhog/mailhog:latest"
  keep_locally = false
}

resource "docker_container" "mailhog" {
  image = docker_image.mailhog.latest
  name  = "mailhog"
  ports {
    internal = 8025
    external = 8025
  }
}

output "mailhog_url" {
  description = "mailhog server url"
  value       = "${docker_container.mailhog.ports[0].ip}:${docker_container.mailhog.ports[0].external}"
}

output "mailhog_container" {
  description = "mailhog server url"
  value       = docker_container.mailhog.network_data[0]
}


# # jenkins configuration
# variable "jenkins_username" {
#   description = "jenkins username"
#   default     = "admin"
# }

# variable "jenkins_password" {
#   description = "jenkins username"
#   default     = "admin"
# }

# provider "jenkins" {
#   server_url = local.jenkins_server_url
#   username   = var.jenkins_username
#   password   = var.jenkins_password
# }

# output "jenkins_username" {
#   description = "jenkins username"
#   value       = var.jenkins_username
# }

# output "jenkins_password" {
#   description = "jenkins password"
#   value       = var.jenkins_username
# }
