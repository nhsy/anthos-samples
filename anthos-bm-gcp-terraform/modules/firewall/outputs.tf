output "ssh_firewall_name" {
  value = google_compute_firewall.allow_inbound_mgmt_ssh.name
}