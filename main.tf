locals {
  user_data = templatefile("${path.module}/cloud-init/config.yaml", {
    jetbrains_image = var.jetbrains_image
  })
}


resource "google_compute_instance_from_template" "instance" {
  name = "jetbrains-on-gcp"
  zone = "europe-west1-b"

  source_instance_template = google_compute_instance_template.jetbrains.id

  can_ip_forward = false
}


resource "google_compute_instance_template" "jetbrains" {
  name_prefix  = "jetbrains-"
  machine_type = var.machine_type

  tags = var.network_tags

  network_interface {
    subnetwork = var.subnetwork
  }

  disk {
    source_image = var.source_image //"cos-89-lts"
    disk_size_gb = var.disk_size_gb
    auto_delete  = true
    boot         = true
  }

  service_account {
    email = var.service_account

    scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/servicecontrol", 
    ]
  }

  metadata = {
    user-data = local.user_data
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
  }
  
  can_ip_forward = false
}
