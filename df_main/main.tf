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
  region      = "europe-west1-b"
}

//resource "google_dataflow_job" "big_data_job" {
//	name = "dataflow-job"
//	zone = "europe-west1-b"
//	template_gcs_path = "gs://dataflow-templates/latest/Cloud_PubSub_to_Cloud_PubSub"
//	temp_gcs_location = "gs://dataflow_runtime_bucket/staging"
//	parameters {
//	outputTopic = "projects/generated-wharf-205016/topics/output_topic"
//	inputSubscription = "projects/generated-wharf-205016/subscriptions/myInputSub1"
//	}    
//	}
