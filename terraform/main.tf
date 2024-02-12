provider "digitalocean" {
  token = dop_v1_c2d5e614da2a28eccf28fd2342a09916e1cccb9e2595d09a28c959fafc69557e
}

resource "digitalocean_droplet" "example" {
  name   = "example"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  image  = "ubuntu-22-04-x64"
}

output "droplet_ip" {
  value = digitalocean_droplet.example.ipv4_address
}
