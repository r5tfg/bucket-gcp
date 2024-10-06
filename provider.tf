#GCP provider

provider "google" {
  project = var.gcp_project
  credentials = file(var.gcp_svc_key)
  region = var.gcp_region
}