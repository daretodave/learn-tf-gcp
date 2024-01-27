terraform {
  required_providers {
    google = {
      version = "~> 5.0.0"
    }
  }
}

provider "google" {
  project     = "smiling-theory-412514"
  region      = "us-east1"
  zone        = "us-east1-b"
}

data "google_client_config" "current" {
  provider = google
}

resource "google_kms_key_ring" "terraform_state" {
  project = data.google_client_config.current.project
  name     = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  location = "us"
}

resource "google_kms_crypto_key" "terraform_state_bucket" {
  name            = "test-terraform-state-bucket"
  key_ring        = google_kms_key_ring.terraform_state.id
  rotation_period = "86400s"

  lifecycle {
    prevent_destroy = false
  }
}


resource "google_project_iam_member" "default" {
  project = data.google_client_config.current.project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:service-${data.google_client_config.current.project}@gs-project-accounts.iam.gserviceaccount.com"
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  versioning {
    enabled = true
  }
  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform_state_bucket.id
  }
  depends_on = [
    google_project_iam_member.default
  ]
}

module "network" {
  source = "./modules/google-vpc"

  network_name = "k8-vpc"
}