terraform {
  backend "consul" {
  address = "35.237.122.239"
    path    = "remote-state-file"
  }
}

// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "generated-wharf-205016"
  region      = "us-east1-b"
}
resource "google_compute_instance" "default" {
	name = "test"
	machine_type = "n1-standard-1"
	zone = "us-east1-b"
	
	tags = ["name", "sample-instance"]
	boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1604-lts"
    }
  }

  // Local SSD disk
  scratch_disk {
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
 }

resource "google_compute_firewall" "consul_ingress" {
    name = "consul-int-firewall"
    network = "default"

    allow {
        protocol = "tcp"
        ports = [
            "5432" #psql
        ]
    }

}
