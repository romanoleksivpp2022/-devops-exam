# SSH Key
resource "digitalocean_ssh_key" "main" {
  name       = "${var.prefix}-key"
  public_key = var.ssh_public_key
}

# VPC
resource "digitalocean_vpc" "main" {
  name     = "${var.prefix}-vpc"
  region   = var.region
  ip_range = "10.10.10.0/24"
}

# Firewall
resource "digitalocean_firewall" "main" {
  name = "${var.prefix}-firewall"

  droplet_ids = [digitalocean_droplet.main.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8001"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8002"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8003"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Droplet (VM)
resource "digitalocean_droplet" "main" {
  name     = "${var.prefix}-node"
  size     = "s-4vcpu-8gb"
  image    = "ubuntu-24-04-x64"
  region   = var.region
  vpc_uuid = digitalocean_vpc.main.id
  ssh_keys = [digitalocean_ssh_key.main.fingerprint]
}

# Spaces Bucket
resource "digitalocean_spaces_bucket" "main" {
  name   = "${var.prefix}-bucket"
  region = var.region
}
