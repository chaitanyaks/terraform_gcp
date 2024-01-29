
terraform {
  backend "consul" {
  address = ""
    path    = "remote-state-file"
  }
}

// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "generated-wharf-205016"
  region      = "us-east1-b"
}

resource "google_storage_bucket" "bucket_object" {
  name = "bucket_chaitu"
}

resource "google_storage_bucket_object" "file_object" {
  name = "my_file_object"
  source = "main.tf"
  bucket = "bucket_chaitu"
}
  
