terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
    }
  }
}

# Specify the Terraform provider to use
provider "digitalocean" {
  token = var.do_token
}

# Setup a DO droplet
resource "digitalocean_droplet" "example" {
  name   = "example"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-22-04-x64"
  ssh_keys = [
    var.ssh_key_fingerprint
  ]
}

# Setup a DigitalOcean firewall
resource "digitalocean_firewall" "web_server_firewall" {
  name = "web-server-firewall"

  droplet_ids = [digitalocean_droplet.example.id]

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
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "53"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

# Output the public IP address of the new droplet
 output "public_ip_server" {
  value = digitalocean_droplet.example.ipv4_address
}