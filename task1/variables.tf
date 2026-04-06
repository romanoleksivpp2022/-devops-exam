variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "fra1"
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "oleksiv"
}
variable "spaces_access_key" {
  description = "Spaces Access Key"
  type        = string
  sensitive   = true
}

variable "spaces_secret_key" {
  description = "Spaces Secret Key"
  type        = string
  sensitive   = true
}
variable "ssh_public_key" {
  description = "SSH Public Key"
  type        = string
  sensitive   = true
}
