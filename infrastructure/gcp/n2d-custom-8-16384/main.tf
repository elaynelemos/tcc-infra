# Este código é compatível com a versão 4.25.0 do Terraform e com as que têm compatibilidade com versões anteriores à 4.25.0.
# Para informações sobre como validar esse código do Terraform, consulte https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration
terraform {
	required_providers {
		google = {
	    version = "~> 5.25.0"
		}
    }
}

provider "google" {
  project     = "erll-research"
  region      = "us-east1"
}

resource "google_compute_instance" "gector_api_server" {
  boot_disk {
    auto_delete = true
    device_name = "gector-api-server-n2d-custom-8-16384"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240307b"
      size  = 60
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    project = "erll-research-gector"
  }

  machine_type = "n2d-custom-8-16384"

  metadata = {
    ssh-keys = "elaynelemos:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC9Qd2Qt2cve8S18G9MfT36kUFjq3ORmw7SAr90xm2P8 elaynelemos@personal"
  }

  min_cpu_platform = "AMD Milan"
  name             = "gector-api-server-n2d-custom-8-16384"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/erll-research/regions/us-east1/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "954524726907-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server", "https-server"]
  zone = "us-east1-b"
}
