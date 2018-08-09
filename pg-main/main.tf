terraform {
  backend "consul" {
  address = "35.237.122.239"
    path    = "remote-state-file"
  }
}

// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("../account.json")}"
  project     = "generated-wharf-205016"
  region      = "us-east1-b"
}
resource "google_compute_instance" "default" {
	name = "postgres-instance"
	machine_type = "n1-standard-1"
	zone = "us-east1-b"
	tags = ["name", "postgres-instance"]
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
     // installing postgressql9.6
	metadata {
	   startup-script = << EOF
add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -sc)-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt-get update -y
apt-get install postgresql-9.6 -y




EOF
 }

resource "google_compute_firewall" "postgres-ingress" {
    name = "postgres-firewall"
    network = "default"

    allow {
        protocol = "tcp"
        ports = [
            "5432" #psql
        ]
    }

}
