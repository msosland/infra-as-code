resource "google_compute_instance" "test-instance" {
  name         = "test-instance"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  # boot disk specifications
  boot_disk {
    initialize_params {
      image = "raddit-base"
    }
  }

  # networks to attach to the VM
  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_project_metadata" "raddit" {
  metadata {
    ssh-keys = "gcp-test-user:${file("~/.ssh/gcp-test-user.pub")}" 
  }
}

resource "google_compute_firewall" "raddit" {
  name    = "allow-raddit-tcp-9292"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
}
