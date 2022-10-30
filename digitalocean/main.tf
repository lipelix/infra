terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lipelix"

    workspaces {
      name = "infra"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_api_key
}

locals {
  dokku_hostname = "dokku-do"
}

resource "digitalocean_droplet" "dokku-server" {
  image              = "ubuntu-22-10-x64"
  name               = local.dokku_hostname
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  monitoring         = true
  ipv6               = false
}
