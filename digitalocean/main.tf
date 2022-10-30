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

resource "digitalocean_droplet" "dokku_server" {
  image      = "dokku-20-04"
  name       = local.dokku_hostname
  region     = "fra1"
  size       = "s-1vcpu-1gb"
  monitoring = true
  ipv6       = false
  ssh_keys   = [digitalocean_ssh_key.terraform_dokku.fingerprint]
}

resource "digitalocean_ssh_key" "terraform_dokku" {
  name       = "Terraform Dokku"
  public_key = var.digitalocean_ssh_pub_key
}

output "droplet_ip" {
  value = digitalocean_droplet.dokku_server.ipv4_address
}
