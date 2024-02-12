variable "do_token" {
  description = "DigitalOcean Api Token"
}

variable "ssh_key_fingerprint" {
  description = "Fingerprint of the public ssh key stored on DigitalOcean"
}

variable "ssh_public_key" {
  description = "Local public ssh key"
  default = "~/.ssh/id_rsa.pub"
}