terraform {
  backend "consul" {
    address = "35.231.85.164"
    path    = "remote-state-file/psql"
  }
}

// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "myproject_ID_12344"
  region      = "us-east1-b"
}


resource "google_kms_key_ring" "my_key_ring" {
  name     = "my-key-ring"
  project  = "my-project"
  location = "us-central1"
}

resource "google_kms_crypto_key" "my_crypto_key" {
  name            = "my-crypto-key"
  key_ring        = "${google_kms_key_ring.my_key_ring.id}"
  rotation_period = "100000s"
}

#echo -n my-secret-password | gcloud kms encrypt --project my-project  --location us-central1  --keyring my-key-ring  --key my-crypto-key  --plaintext-file -  --ciphertext-file - |  base64
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-8"
      disk_encryption_key_raw = "projects/generated-wharf-205016/locations/global/keyRings/test-keyring/cryptoKeys/key-compute-1"
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

  metadata {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  }
