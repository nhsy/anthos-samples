locals {
  mgmt_ip = ["${chomp(data.http.mgmt_ip.body)}/32"]
}

data "http" "mgmt_ip" {
  url = "https://ipinfo.io/ip"
}

# allow SSH access to bastion
resource "google_compute_firewall" "allow_inbound_mgmt_ssh" {
  name        = "allow-inbound-mgmt-ssh-${var.unique_id}"
  network     = var.network
  description = "Allow inbound SSH"
  direction   = "INGRESS"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = concat(local.mgmt_ip)

  dynamic "log_config" {
    for_each = var.log_config_metadata
    content {
      metadata = log_config.value
    }
  }
}

# allow internal access all
resource "google_compute_firewall" "allow_inbound_internal" {
  name        = "allow-inbound-internal-${var.unique_id}"
  network     = var.network
  description = "Allow inbound internal"
  direction   = "INGRESS"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    var.vpc_cidr
  ]

  dynamic "log_config" {
    for_each = var.log_config_metadata
    content {
      metadata = log_config.value
    }
  }
}