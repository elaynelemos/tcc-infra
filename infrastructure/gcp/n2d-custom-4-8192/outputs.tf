output "public_ip" {
  value       = google_compute_instance.gector_api_server.network_interface.0.access_config.0.nat_ip
  description = "The public IP of the web server."
}
